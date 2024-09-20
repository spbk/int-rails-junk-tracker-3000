// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'
import ReactOnRails from 'react-on-rails';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import React, { useState, useEffect } from 'react';

const VehicleForm = (props) => {
  const [nickname, setNickname] = useState(nickname || '');
  const [mileage, setMileage] = useState(mileage || 0);
  const [numDoors, setNumDoors] = useState(numDoors || 0);
  const [numSlidingDoors, setNumSlidingDoors] = useState(numSlidingDoors || 0);
  const [engineStatus, setEngineStatus] = useState(engineStatus || 'works');
  const [seatStatus, setSeatStatus] = useState(seatStatus || 'works');
  const [vehicleType, setVehicleType] = useState(vehicleType || 'coupe');
  const [formData, setFormData] = useState({});
  const [error, setError] = useState(null);

  useEffect(() => {
    setFormData({
      nickname,
      mileage,
      numDoors,
      numSlidingDoors,
      engineStatus,
      seatStatus,
      vehicleType
    });
  }, [nickname, mileage, numDoors, numSlidingDoors, engineStatus, seatStatus, vehicleType]);


  const handleVehicleTypeChange = (event) => {
    setVehicleType(event.target.value);
    if (event.target.value !== 'mini-van') {
      setNumSlidingDoors(0);
    }
  };


  const handleSubmit = async (event) => {
    console.log(event)
    event.preventDefault();

    try {
      const response = await fetch('/vehicles', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': Rails.csrfToken()
        },
        body: JSON.stringify({
          nickname,
          mileage,
          numDoors,
          numSlidingDoors,
          engineStatus,
          seatStatus,
          vehicleType
        })
      });

      if (response.ok) {
        const result = await response.json();
        console.log('Vehicle created successfully:', result);
        window.location.href = '/vehicles'
      } else {
        const error = await response.json();
        setError('An error occurred while creating the vehicle. Please try again.');
        console.error('Error:', error);
      }
    } catch (error) {
      setError('An error occurred while creating the vehicle. Please try again.');
      console.error('Error:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>Nickname:</label>
      <input
        type="text"
        value={nickname}
        onChange={(e) => setNickname(e.target.value)}
      />

      <label>Mileage:</label>
      <input
        type="number"
        value={mileage}
        onChange={(e) => setMileage(e.target.value)}
      />

      <label>Vehicle Type:</label>
      <select value={vehicleType} onChange={handleVehicleTypeChange}>
        <option value="coupe">Coupe</option>
        <option value="motorcycle">Motorcycle</option>
        <option value="sedan">Sedan</option>
        <option value="mini-van">Mini-Van</option>
      </select>

      {(vehicleType === 'coupe' || vehicleType === 'sedan' || vehicleType === 'mini-van') && (
        <>
          <label>Number of Doors:</label>
          <input
            type="number"
            value={numDoors}
            min="0"
            max="4"
            onChange={(e) => setNumDoors(e.target.value)}
          />
        </>
      )}

      {vehicleType === 'mini-van' && (
        <>
          <label>Number of Sliding Doors:</label>
          <input
            type="number"
            value={numSlidingDoors}
            min="0"
            max={numDoors} // Ensure sliding doors cannot exceed total doors
            onChange={(e) => setNumSlidingDoors(e.target.value)}
          />
        </>
      )}

      <label>Engine Status:</label>
      <select
        value={engineStatus}
        onChange={(e) => setEngineStatus(e.target.value)}
      >
        <option value="works">Works</option>
        <option value="fixable">Fixable</option>
        <option value="junk">Junk</option>
      </select>

      {vehicleType === 'motorcycle' && (
        <>
          <label>Seat Status:</label>
          <select
            value={seatStatus}
            onChange={(e) => setSeatStatus(e.target.value)}
          >
            <option value="works">Works</option>
            <option value="fixable">Fixable</option>
            <option value="junk">Junk</option>
          </select>
        </>
      )}

      <button type="submit">Submit</button>
    </form>
  );
};


const VehicleList = (props) => {
  const {
    vehicles,
  } = props;

  const handleDelete = async (vehicleId) => {
    console.log(vehicleId)
    if(vehicleId == null) return;

    try {
      const response = await fetch(`/vehicles/${vehicleId}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': Rails.csrfToken(),
          'Content-Type': 'application/json'
        }
      });

      if (response.ok) {
        console.log('Vehicle deleted successfully');
        window.location.href = '/vehicles'
      } else {
        console.error('Error deleting vehicle:');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };


  return (<>
    <h1>Vehicles</h1>

    <table>
      <thead>
        <tr>
          <th>Nickname</th>
          <th colSpan="3"></th>
        </tr>
      </thead>

      <tbody>
        {vehicles.map((vehicle) => (
          <tr key={vehicle.id}>
            <td>{vehicle.nickname}</td>
            <td><a href={`/vehicles/${vehicle.id}/edit`}>Edit</a></td>
            <td><button type="button" onClick={() => handleDelete(vehicle.id)}>Destroy</button></td>
          </tr>
        ))}
      </tbody>
    </table>
    <a href="/vehicles/new">New Vehicle</a>
  </>);
}

ReactOnRails.register({
  VehicleList,
  VehicleForm,
});

