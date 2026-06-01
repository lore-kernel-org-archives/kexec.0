Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4048CCD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHCECJLKZVXmKAb51dyXN6SjQcWAQtdhT5+Tc3oFsbc=; b=Fsg9Po1kaYXE2rKY72X5RbC0+/
	KEr99JX99SS+PRNoOVc73aRQ8Jx4yLnerQYu7RiG9wFLU+2KVfIAiv3r1x8945w0qqxUG0ISKRgiQ
	egXYeDG0MX3rC6zqNtnm/UK/i4HmzYoR+Djj8fsHGQlejYo5PbcxluRXrfJHxnqR9WXDNYnuNusTt
	k0K3tlUYJeH835Slpe4vlqPAi5DGj832X8bGp8+Z+gK1xOPeyy/URS4hKP9OOkppZHRtuF76vMA+s
	szGwXdSxkunbHWT7fh0f8wxCh4+vKk/ILti1PvZODJNv8kV3b5N72EMBW1HHL+wSMBbg2AOlMQUGn
	npKegjsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3sI-0000000BJ28-37bI;
	Mon, 01 Jun 2026 14:44:18 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU3sG-0000000BJ1b-3KTs
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 14:44:17 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7e38f2f3800so14874967b3.0
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780325055; x=1780929855; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHCECJLKZVXmKAb51dyXN6SjQcWAQtdhT5+Tc3oFsbc=;
        b=KZrONH53kN3YPtkYAtm4mI1j0+c6xNVyLwLUEoEZfcfQ9koFV9+s+5AyTF/3xKEIzQ
         ANofJOrgG7g9TJ/WVSLb8wUm9Bb2aeCHiO+NxmGOV5yTYIrwcxKOlemyK0QauesSoyu6
         D5RqJxgdz0troDM0j8u/DB86C4jIzjAeozNcRSKBqsjIgquIxCc6Gp48ynswYPxnBdNY
         3XqzRPCXYynv19BZCdO8Qqlgdj0JwRKc6f/Ws+s7fVdIBLwH36DZb8RUNqwb+E8Nw554
         KANyTq6ltHc3w3Twesu1jpQ51O+hmDZj9IwU2RVRSvi/yqU58k6bwDQO/Kgv2fzZW2PB
         91TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780325055; x=1780929855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHCECJLKZVXmKAb51dyXN6SjQcWAQtdhT5+Tc3oFsbc=;
        b=B48V8+3jsCzh/Uao6CXCJ5+fVYd5Inr/fQ0K1OwCpCaNTa343jc6LaOAMr4d96pNqe
         rQE8KB6AUd9cP91+S6VqdlTgqUd3ISGUQI8OG9Jq0PvLFzMWdj6yEtb2XsTcxUKBBFPG
         3D2WqWayYeVJR1T/SkzSgxBGCDDYbPbRyQDnBvvhLyLm1IexD5ibZCCOElpPmC6aAwdO
         mG7OUboin4Xq4E1rIKVoao8a7ZORpAOp5Sp43Erzk98S/J6Swh5sSR3mwLylklsk10IK
         GPB6dg0oI/J1Zk7XT/72BnIqjWQMlmxt/G/AJ6m3iHDAaNQtkYw4gMhW2Vb7A/+iJe23
         ijTA==
X-Forwarded-Encrypted: i=1; AFNElJ/uI3xK1/uRfpwHOHzNz4vL1/0W1MsirzA3/y+PMyw2UMKVjg19AALqCpWypADoFyZe3qA0YQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5s8JVIAq305pu0KmTQSTtCB4x4OeQr7tZZ+lFdpbM7TWthK1V
	HuoU0SCMk6JRifB809KPYX/gbpI7mCywgoqhAkH9ao7ekTjyA2ClDkI/FIANDEOkqRA=
X-Gm-Gg: Acq92OGbzXqHzq+D2ZwWo3EizQfSHrhhqyV/T7jkm3EzKxn8jxbSk1LbtBOoiD8kjfZ
	RpiSiujNwpj78rmhR2ojkMpoNoyCPMc9phXhYJ8uaV+DJDKEK5idP9dpVCFkLfbDURMPf4tmHgm
	qubLvMCsPtck0xMkc9fx4/uS56Kbs8vC+wkhf5Fec7K7CzMdjFSVYeWUCpOvZ36AwiLFGnnKzcD
	xLM6v31zGFt9A7MuOQCm4ITl6YMkuRpuXUBRDX/glkbKzwPHzB4jjLGLAzg1+UeoLCFl1Qb9a7l
	admjLsOsAcZyx22U3/dNAb4TKD6/CFZxLtUL8Whg4BHGKXKiAbHXoyHnJ9J0DuxFKTIfVli5a9E
	xgLvelR5lmchtNIQl/y7p+VbNMIIQwVXvNmjL6Y/X7Ua/jw5rwGY3AJSDco65Mgax3wn+Ed1XYG
	T8v152DPhuh6zWOoiPWIQLwUvLa7c73+Jyc0QULW5hfmtI+hH2U54cg8j4lu8kCdbiRAyBgrAgm
	LJ6dhAfVmBt6825ABhMV4+zWncWk/QamiEH7pPLu3O5q1cRA0sc/Q==
X-Received: by 2002:a05:690c:3511:b0:7dc:e580:7f8 with SMTP id 00721157ae682-7e05d0172d6mr107595267b3.26.1780325055588;
        Mon, 01 Jun 2026 07:44:15 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e17c9ac78asm41186257b3.43.2026.06.01.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:44:15 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:44:14 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 09/13] liveupdate: Remove limit on the number of
 sessions
Message-ID: <ah2ardT1UjymdMqd@google.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-10-pasha.tatashin@soleen.com>
 <2vxzfr36fjcj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzfr36fjcj.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_074416_865048_8138473A 
X-CRM114-Status: GOOD (  24.34  )
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

On 06-01 16:03, Pratyush Yadav wrote:
> On Sat, May 30 2026, Pasha Tatashin wrote:
> 
> > Currently, the number of LUO sessions is limited by a fixed number of
> > pre-allocated pages for serialization (16 pages, allowing for ~819
> > sessions).
> >
> > This limitation is problematic if LUO is used to support things such as
> > systemd file descriptor store, and would be used not just as VM memory
> > but to save other states on the machine.
> >
> > Remove this limit by transitioning to a linked-block approach for
> > session metadata serialization. Instead of a single contiguous block,
> > session metadata is now stored in a chain of 16-page blocks. Each block
> > starts with a header containing the physical address of the next block
> > and the number of session entries in the current block.
> >
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> [...]
> > @@ -63,13 +58,15 @@
> >  #define _LINUX_KHO_ABI_LUO_H
> >  
> >  #include <linux/align.h>
> > +#include <linux/kho/abi/block.h>
> >  #include <uapi/linux/liveupdate.h>
> >  
> >  /*
> >   * The LUO state is registered under this KHO entry name.
> >   */
> >  #define LUO_KHO_ENTRY_NAME	"LUO"
> > -#define LUO_ABI_COMPATIBLE	"luo-v3"
> > +#define LUO_COMPAT_BASE		"luo-v3"
> > +#define LUO_ABI_COMPATIBLE	LUO_COMPAT_BASE "-" KHO_BLOCK_ABI_COMPATIBLE
> 
> That's clever :-)
> 
> [...]
> >  int luo_session_serialize(void)
> >  {
> >  	struct luo_session_header *sh = &luo_session_global.outgoing;
> >  	struct luo_session *session;
> > -	int i = 0;
> > +	struct kho_block_it it;
> >  	int err;
> >  
> >  	down_write(&luo_session_serialize_rwsem);
> >  	down_write(&sh->rwsem);
> >  	*sh->sessions_pa = 0;
> >  
> > +	kho_block_it_init(&it, &sh->block_set);
> > +
> >  	list_for_each_entry(session, &sh->list, list) {
> > -		err = luo_session_freeze_one(session, &sh->ser[i]);
> > -		if (err)
> > +		struct luo_session_ser *ser = kho_block_it_next(&it);
> > +
> > +		if (!ser) {
> > +			err = -ENOSPC;
> >  			goto err_undo;
> > +		}
> >  
> > -		strscpy(sh->ser[i].name, session->name,
> > -			sizeof(sh->ser[i].name));
> > -		i++;
> > -	}
> > +		err = luo_session_freeze_one(session, ser);
> > +		if (err) {
> > +			kho_block_it_prev(&it);
> > +			goto err_undo;
> > +		}
> >  
> > -	if (sh->header_ser && sh->count > 0) {
> > -		sh->header_ser->count = sh->count;
> > -		*sh->sessions_pa = virt_to_phys(sh->header_ser);
> > +		strscpy(ser->name, session->name, sizeof(ser->name));
> >  	}
> > +
> > +	kho_block_it_finalize(&it);
> > +
> > +	if (sh->sessions_pa && sh->count > 0)
> 
> Nit: Why check for sh->sessions_pa? It can never be NULL.

Good point, I will remove it.

> 
> Other than this, 
> 
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> 
> > +		*sh->sessions_pa = sh->block_set.head_pa;
> >  	up_write(&sh->rwsem);
> >  
> >  	return 0;
> >  
> >  err_undo:
> >  	list_for_each_entry_continue_reverse(session, &sh->list, list) {
> > -		i--;
> > -		luo_session_unfreeze_one(session, &sh->ser[i]);
> > -		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
> > +		struct luo_session_ser *ser = kho_block_it_prev(&it);
> > +
> > +		luo_session_unfreeze_one(session, ser);
> > +		memset(ser->name, 0, sizeof(ser->name));
> >  	}
> >  	up_write(&sh->rwsem);
> >  	up_write(&luo_session_serialize_rwsem);
> 
> -- 
> Regards,
> Pratyush Yadav

