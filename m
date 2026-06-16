Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA37CD98E1
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJNdmkiK3PhuRperaiQ6089ov2561C0H0udd8xzGUrk=; b=ZA7rm393Pa4gOf82ocSb9f46Pt
	PlmotHckQ2ex0wd3xmYmhZeQRb2WVU5rvOvsT0G2i3Wy9jIJDXWhxMDCASFWM92yRVvsf7lvolFll
	X4CKmu3SPxl6xeKwRX1vN5BuHbhEx5ER2NFwHr1b/a7QhJtlPTN5fu7nNRKGmpanTvNdYDPQaQkTB
	8BElE0M2Xp0TH5SKsBNI0yatle3OauEJr8fxhQSWP+Cg1CH2shp5jfZXI2rneub7bYMbmlh8idS/W
	IjeDKKQvXspACdlPGhG4wOZqYdagqaBlFPHh0BXBcG0fcgqJoUB0xmR5ZuHV3llWPc6zlwAPK5rFM
	eDiGuq/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZZFf-0000000GFSV-08Qo;
	Tue, 16 Jun 2026 19:15:11 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZZFd-0000000GFS2-0BWm
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 19:15:10 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c6a4eccab1so10075ad.1
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781637307; x=1782242107; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uJNdmkiK3PhuRperaiQ6089ov2561C0H0udd8xzGUrk=;
        b=nAn5Cl8TczOm5XD+At9fLOHtEtvGXAoO0bR+27X1+LS6HjWcS599ACLdeGJsMPCzdc
         ertpHRjlVExWbGOrDL35ayiKwcv7JQXRwVdlKZGUyYm30QxpqMlL5FAvNWzd6uclUGnv
         xRkN2p6KDLhIF6A05IRPlJRkKO29tJYfi7h/n9LP3a3Ns4oRFFBqjG9wtxUkvU/Wnr1q
         uYfnER1+Z8bZvRLJCcB6cjIjt0bKNUwVZRgJ/cNbzAjP3nIRHJoZJKzh3Ce/WsnFGFvu
         9Rx/pmDnk5AbYhw97Ij9h41gR6ycjQLFHIgKVtyZLuaOXnH4DXgOU27MGlmFobY6QiyC
         WW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637307; x=1782242107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJNdmkiK3PhuRperaiQ6089ov2561C0H0udd8xzGUrk=;
        b=N4FMcD+5TJ77zslP842re39MqsxUEnmRuCRmXZ7HojODOEdPeUswA53A0Tbn6iVyFl
         vhb13PvGw3oU6YHsSO4I52HoZNCBgUZyo5Vc506RwtUPH5aTWl19IHPisIMN2ugHaro0
         HAyKq9tRkce4pqyCfHPCsxE4DZvZdE7OG239ybaUbrv8pIzkC2a7PiiBKh1Gi8S105a7
         +Ke0V579m/PkJw4Uphe+JHJpBBXDxUtq+ItHwIw+bkcYwNmTgrIfyw/Gl3sgA+kXoVXB
         KHP/8g+Zr1eQYmk5UvoeF3c9KyoqYMGohsbGYn6b2i46s9OFLnmkafMUehnI/HLxvrXL
         IKEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xq6ejOqsVXTXseI2yC/MaQyGP1mforbhpo7MIWJynUklVSuLCPG1WgG+Zp/jOjKDEhRn2xw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdRnXdXTr8NVcRbgO+aup51/GsioEKDGNQEYExrsgx/e0KiMxv
	+La7w/hxojsqpYassgmxZ99HzRylptYszZu+yftfGGxMnrT/c8P9S/c/8lFGjRJ8yQ==
X-Gm-Gg: AfdE7ckOlypfBATY05e48D2xsGuPq5DsW7NDl8bINmjkEACj2vl//+2IbEzwnecUm5p
	HmqdOLbDaWtN+AyrigN95J1af010Y0gf8rUox0005YKAtFDCebvgs5AqbgbJlsEjxTzhtQHDIGm
	tcFGBPnjI7nikSDI6AJgrB5HV0EoVQpwLXBPZM8/qVxsoekoRbKPY+8xaMncPfsvMKSIhBypKl5
	hVhXIqmW+/TueAosRCepy8t9nHGX1IVXqYggMOqYAYrHIwVtf9RrrAq4uInnhgltkD34V9YF7JF
	dYhAPMo8Qrhg7cHF9SqOHSzvAMfav1YVywjRO57D4peyP3/lXMyZa1NSRgiNGkgCPhLCT8h6P3l
	urgh83QRFzSsHIY0Dpl832cfbWeTswzLRHQ4uLCD3/wzdN77bqswwTcTXS0VrQncAEcWpDej5db
	xIBDLH6ULa3CsMjgc43dYrPLNGeZvrY5vRWCyY2CWPaW0ffFBDhKOwp49SGbjH88L8moM/4qkkX
	rCwxFafI704zw1suyU=
X-Received: by 2002:a17:902:f706:b0:2c6:8564:46b9 with SMTP id d9443c01a7336-2c6bbb030femr394805ad.30.1781637306612;
        Tue, 16 Jun 2026 12:15:06 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d86501sm132585345ad.61.2026.06.16.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:15:06 -0700 (PDT)
Date: Tue, 16 Jun 2026 19:15:03 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/3] kho: Add support for kunit mocking KHO restore API
Message-ID: <ajGOIOqBY1pazq5g@google.com>
References: <20260521193202.746810-1-skhawaja@google.com>
 <ah0t9Ss_S-5iOM59@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ah0t9Ss_S-5iOM59@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_121509_255148_FE9ECC99 
X-CRM114-Status: GOOD (  20.66  )
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

Hi Mike,

Sorry for the late reply, I got pulled into some other stuff.

On Mon, Jun 01, 2026 at 10:00:05AM +0300, Mike Rapoport wrote:
>Hi Samiullah,
>
>On Thu, May 21, 2026 at 07:31:59PM +0000, Samiullah Khawaja wrote:
>> To write kunit tests for preservation and restoration of liveupdate
>> state in various subsystems without triggering the actual kexec, the KHO
>> restore API needs to be mocked by the test writer. The mocking is done
>> to allow testing of the individual components or functions in isolation.
>>
>> The patch series adds the following to support kunit testing when using the KHO
>> API:
>>
>> - Add static stub hooks to mock the KHO restore API so the restore path
>>   can be tested without triggering kexec.
>> - Add helper function that can be used by the test writer to check if
>>   memory is preserved in KHO tree.
>>
>> Finally, it adds a KUnit test for the KHO API that verifies the allocation of
>> preserved memory, and the preservation/restoration of pages and folios.
>
>I looked at the tests for preservation and apparently they don't add
>coverage beyond the existing KHO selftest. How hard and/or intrusive would
>be adding tests for example for error paths?
>
>Do you have an example of a kunit test for another subsystem that would
>benefit from mocking of KHO APIs?

I think intrusive tests to get more coverage for KHO would probably not
use the stubs added in this series, as these are meant to mock the KHO
restore API itself.

My motivation was to allow downstream users of KHO to test their own
preservation logic (making sure their ABI doesn't have bugs). LUO or the
recently added KHO linked-block can probably be a start?

The KHO kunit test added here is just a minimum example of how to use the
stubs, which is why it doesn't provide much extra coverage.

I am perfectly happy to drop this patch for now. We can get this in
later when we have kunit tests for KHO users. WDYT?
>

[snip]
>
>-- 
>Sincerely yours,
>Mike.

Thanks,
Sami

