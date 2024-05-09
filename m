Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C04C10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x2AdUv+flnUTeCcUwBm8yjfTSKYxmUqeW4+F8W2nxxk=; b=zjGOCxcHSwfcnU
	kBWqfkXdFXsY3Z+PHRt248PLr0JDMk11aaNqjaDp1BZDP6etgkQR77eZJ7QZvQCKEE+JG3N7O+zeo
	wyz3lt5+2SbQvV994CS6FV1BpVru8srQ0SABuC/Fi8412yXBl6cA7OIooagcHnVdQq6itutKQ5iJE
	rPJuaEFp41u0QFyV0QfPOEEDpSAS1ghvJ8eJuw9yMlthI/nikGxXDjGiGMVd2UllwMQVumskZoc9+
	RYI3YSm0ub4nQOsqjFh3TEwTGlntiePqYmfHXQc5PPMgZs8xTOSHWdqAAXfnaNf3eL+6aw1T9QBBI
	ZqY2x0jJLU0YnD6siSOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4zwJ-00000000xcQ-2BBn;
	Thu, 09 May 2024 09:19:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4zwG-00000000xas-1wdE
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 09:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715246381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vMs94siUkMQ0Z1b8w6GKdXPEsrvSAFnIe75Ff7i9K4=;
	b=UgczYuyBueQ8GahjpIsZ6loRjIDJDb3ozNvPHqel5T0ArG5ySTGLefRjVKptYDbFvbFgku
	mGCHwjWquCphlVWD/l/E953dAjGXmRMbX5QNLQ9+g/1Z/Jbis43HElEpNBT+5jywS0gh/6
	5ET/Yz3nroDh6Q7oVxYBjtx+gWMNLIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-GzZXXonEO0KfyXP1mNrMpg-1; Thu, 09 May 2024 05:19:40 -0400
X-MC-Unique: GzZXXonEO0KfyXP1mNrMpg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34da8f1bf7cso445318f8f.2
        for <kexec@lists.infradead.org>; Thu, 09 May 2024 02:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246379; x=1715851179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vMs94siUkMQ0Z1b8w6GKdXPEsrvSAFnIe75Ff7i9K4=;
        b=JJ1tD+MUIUTpw+3D8yt/2oATrzAWJ2cxPsBYYm0juJ38SVueL6Qyxl4bmUi0R1GqXQ
         wa8NpBpGstwcDupAtqQGpjtwYTb5PPavuGLgpFJlTaqxPevGTa9t1m/3dPyYM0lcUNFv
         6kI3FCWkriQ90xZb7AJ3k5+8CLjSvCxDD7vhXAS9NsOajRoqyBsiHFlxjU9FKGv/COtF
         b//jEmQXSJR8F8VFtEqFwA8E7IyFUYzcGMYIXQNy8ialwgyvJEbPqwlOH+n9yCP4CEPn
         17ILC5ZS0aqMmEE3W6KRrCdPREVnvhknKUGFhjAOtK6L1zLnDfdytdZld/hri1D7wdZx
         m22g==
X-Forwarded-Encrypted: i=1; AJvYcCX0Ez1MA/fsAX0iPootUBSKniCja2zSOSNxXs9TC1r96c/fsfBzsh34SoKjzeg6tuvCfrtWlSoIHKD8tTfEx2dDkrmhZrOcugfj
X-Gm-Message-State: AOJu0Yy9Fl6Nmc9Yxn2efBU0InkFzPNyUOyeFwodI785GMkzjmAqAezi
	NDrq48XbpFA3/oZHDESnMiRNLVpko4TJwILu3JYCkYqnz0jcjR8AfQYuCmmwKNZ6Jhyw4Is5iFj
	zQ8fPskALIwYUQF4P23OpU9qEKjaidvqr8fPhUlFYDHvubrul3kbfKksf3w==
X-Received: by 2002:a5d:4533:0:b0:34c:72aa:6fe0 with SMTP id ffacd0b85a97d-34fca241368mr4389955f8f.18.1715246379021;
        Thu, 09 May 2024 02:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJh3SuqH3yNbzIZYnYk688DTBqYlucoBOzYmZ3Dv4FrnmITUrIQUfykuQrafBaMOakQpi/Zw==
X-Received: by 2002:a5d:4533:0:b0:34c:72aa:6fe0 with SMTP id ffacd0b85a97d-34fca241368mr4389931f8f.18.1715246378646;
        Thu, 09 May 2024 02:19:38 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a8454sm1172307f8f.56.2024.05.09.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:19:37 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexander Graf <graf@amazon.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
In-Reply-To: <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
 <87msp8mmpq.fsf@redhat.com>
 <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
Date: Thu, 09 May 2024 11:19:36 +0200
Message-ID: <877cg3fil3.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_021944_754844_4701814E 
X-CRM114-Status: GOOD (  16.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Alexander Graf <graf@amazon.com> writes:

> Correct. With IMA, you even do exactly that: Enforce a signature check 
> of the next binary with kexec.
>
> The problem is that you typically want to update the system because 
> something is broken; most likely your original environment had a 
> security issue somewhere. From a pure SEV-SNP attestation point of view, 
> you can not distinguish between the patched and unpatched environment: 
> Both look the same.
>
> So while kexec isn't the problem, it's the fact that you can't tell 
> anyone that you're now running a fixed version of the code :).

...

>
> I'm happy for CoCo to stay smoke and mirrors :). 

"Only a Sith deals in absolutes" :-)

> But I believe that if 
> you want to genuinely draw a trust chain back to an AMD/Intel 
> certificate, we need to come up with a good way of making updates work 
> with a working trust chain so that whoever checks whether you're running 
> sanctioned code is able to validate the claim.

Launch measurements are what they are, they describe the state of your
guest before it started booting. There are multiple mechanisms in Linux
which change CPL0 code already: self-modifying code like static keys,
loadable modules, runtime patching, kexec,... In case some specific
deployment requires stronger guarantees we can probably introduce
something like 'full lockdown' mode (as a compile time option, I guess)
which would disable all of the aforementioned mechanisms. It will still
not be a hard proof that the running code matches launch measurements
(because vulnerabilities/bugs may still exist) I guess but could be an
improvement.

Basically, what I wanted to argue is that kexec does not need to be
treated 'specially' for CVMs if we keep all other ways to modify kernel
code. Making these methods 'attestable' is currently a challenge indeed.

-- 
Vitaly


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
