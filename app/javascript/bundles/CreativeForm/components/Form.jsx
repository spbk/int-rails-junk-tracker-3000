import React, { useState } from 'react';

const CreativeForm = (props) => {
  const {
    vehicle,
  } = props;

  const [nickname, setNickname] = useState(vehicle.nickname || '');

  return (
    <div>
      <div className="field">
        <label>Nickname</label>
        <input id="nickname" type="text" value={nickname} name='vehicle[nickname]' onChange={(e) => setNickname(e.target.value)} />
        <div>{nickname}</div>
      </div>
    </div>
  );
};

export default CreativeForm;
