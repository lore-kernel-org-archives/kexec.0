Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D76BCD343B
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 15:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmP5Cnx0QocTDrzF4aQm1ITmtTww9O7YQ/iIm+fw4/E=; b=3iw0VAf/lGQGIeRFyfc6Ye6BxU
	OSqOSdIw0dWcGBgPJJFkvrYvVBuRJd664wBtCogMev+xQ6iHmIeC4MLJfn496zZPus6OltlCsrarx
	tiws4BmMtoZxQT4ba4b9HmicLIKQroKI3nY83mYBAFx++o20SS+nykYPsI/2qpXnDD8RGrdLPJ55B
	mApoHrCu2aQmeNH2e4AaVMfOfOm7jtYBij7adI7WIhizfGSTnbXxEY3oKKx5iUIQgfdyDPUqq2k3r
	eKDMatjJ4Ie2vXD9dclWCvAyLNgFr7khQALKEVSKRD62qadVywfaKtMKwPHJHRfenlqHr9TRpVP63
	E5VrUtdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKe8D-00000001Jow-3RJ3;
	Wed, 06 May 2026 15:25:49 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKe8A-00000001Jn3-1LvZ
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 15:25:46 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-7bd65714dcaso57225057b3.3
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778081145; x=1778685945; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmP5Cnx0QocTDrzF4aQm1ITmtTww9O7YQ/iIm+fw4/E=;
        b=bDM/3Iwk/0avJRyZyZYNvfsOJv7+jjRBra1o/YIIa8Y5XVD57o8vjJ8iyPcAtQ1vxp
         E58MN/Meug0eLA5UDDMT0/hPFBo3jrKSN5yJT6eudz4SFy5CwvqcG3j95DYOKRoRFXE2
         TTBIDT5HCfPG+UThVruZgMuyjuusHslom05ZOU9TpbLw9jz/p6rtQXMFY8d7o/bL1yKA
         chuoXNsSG2MQirX4IOujMsmhB+iM7kCegyx139xv8u/78h0JDwX34TqzgjA7XaQJtbpj
         zfAhHnUPiIWzeHvQsFXewS4w7jaT+7DIM5FKhqL2Rgyjg8MdTGlE02JaaloUXrNqa7Wh
         rwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081145; x=1778685945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmP5Cnx0QocTDrzF4aQm1ITmtTww9O7YQ/iIm+fw4/E=;
        b=Zi6ALYo75qU3nrZk+/4Nx7cAKUwnjs+pMS6BkSri7ExigORZQZCic/F9X/GhCTuIgq
         mRH0O7f2bQ2zKkz2kHjsS2g2LnuUACB5+rYIRAKEJ+nutAbY3XovGuAx4lKQjBx9H15p
         nHOICrBa2viRCaBPvVQMggfsXk4Clj/ZtifRFbAVlnhhOkxINkJXiT7OM8hMxvh1B3Iq
         oUsX2cm4XPTJ3wFq1J7sjwXJqvZQB7yDk6CC0WIBEXfAmEiK+iRQnPr+qWUzXaIzLP6m
         hFy/geBsUf6MVIW+/xGgAC2Irru1WQNADZOoir6RAiQjOIeNYWlgmN9kjj+YsE9cHvGk
         YswA==
X-Forwarded-Encrypted: i=1; AFNElJ9XV1qWR5WoyWcdoNHbdAq7aeDBOeEmRYQH8LUJ5p3xNl2wCiAz9vM8zJdwmeUx0OJmSIY2WA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzo/NXfHsVIC2GCSdIi34Bp6Kot666EvCqls7mlzx4BMDWS0MN6
	xaiY99eX1YDJRlQo6QDSplrsE0/YT0qbhkqMj0EyFEnGRE3q7qx36Zu4g+6u4Yyb3bQ=
X-Gm-Gg: AeBDievoAPNDXgRlmZ9VC+07DMmywwTH9kUXmL3GZs+N4sWkiyclZ0OB8kba1yvaRfj
	VzlpXW73r92opqYCucoQ2l4s9/0/QVd0UA3lyfbY5ucx8SJ7mzlt07dMaPfcgsOmJsymQJAlQ0G
	oBtSjj5GqnWy7Y4QFSYodqjE7RD1wL5AwvS9WOM7+bb8/R7xBDqqR57M1GSZFJRiZ0pc6RYZcg/
	CoD9kOHJS5oOPbBGEl8i4yUToSRQxln94RtW/RyVg2Fnortj9S89bE4MHAXBD+tQMglHx+JBi2I
	gU8kjC+FEYCeR+al8gKkb5vE1OQchMHF/ftd+6kwf4CqhOIbG94YVH8d/+Vza3xg3cunhl0VLax
	QO71rooZXfPHaVE8A0rDHFzayRRKXcukUsgZj15o1EmIhnIo2HEzbWzMXOSJZdn2ZFhqv5pfyyi
	8W8uD+qWsZRrk3a00WUv67tMUALxNlTMM3QZrTM5bW2raxAaGjSrIQHlZUimbK/UpdhBWUAG80T
	P+YGCksJHaDbZWmPD5FurU5MBqyKitaQA/wCIdJ
X-Received: by 2002:a05:690c:12:b0:7bd:5c7d:4b15 with SMTP id 00721157ae682-7bdf5d651ecmr44465647b3.5.1778081145156;
        Wed, 06 May 2026 08:25:45 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66885907sm80888937b3.43.2026.05.06.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:25:44 -0700 (PDT)
Date: Wed, 6 May 2026 11:25:43 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, liaoyuanhong@vivo.com, 
	rafael.j.wysocki@intel.com, piliu@redhat.com, kexec@lists.infradead.org, graf@amazon.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v1 2/3] liveupdate: block outgoing session mutations
 during serialization
Message-ID: <aftaoEKcC_rpB6jm@google.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
 <20260506043200.2025677-7-pasha.tatashin@soleen.com>
 <2vxzy0hwzzym.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzy0hwzzym.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_082546_363952_B35EB300 
X-CRM114-Status: GOOD (  15.78  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 05-06 10:47, Pratyush Yadav wrote:
> On Wed, May 06 2026, Pasha Tatashin wrote:
> 
> > Introduce a 'rebooting' flag in the session header to ensure that once
> > serialization has started, no new outgoing session mutations (creations
> > or file preservations) can occur.
> 
> Would it be a better idea to hold the session header lock and locks of
> each session? This would prevent anyone else from getting access to any
> of the sessions, and we don't have to worry about all the weird cases
> when one might add a file to a serialized session or something similar.
> 
> Once liveupdate_reboot() returns success, there is no going back anyway
> so I don't think it matters much that some tasks will be left waiting.

Overall, we can do that. The only possible issue I can think of is that 
we might get some stupid warnings if the shutdown takes too long:

INFO: task ... blocked for more than ... seconds
followed by a call trace.

But that is unlikely, and it also means that userspace has been trying 
to mutate sessions when it should not have, so I think your approach is 
workable. Let me update the implementation.

Pasha

