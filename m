Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F76606A31C
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jzGIu8FB;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQXGQMZf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qu+tAJYAg4+65Dcz+qLtk1wN9QKpyo0OAAyklv+UhaQ=; b=jzGIu8FBTAGymG
	w1GY/zJ8cI7rGtNeC50oUwv0wwsnyZxTkPOIR36E5zrctROZMw4/WF5UxfABkVBxSrFXnUcwwVaXp
	McTQ/iih8grQkhBebqT2FFQLt0iQfKNG5pK2EeppAilZOJyJ19zDcRYsYhALM+iok7qnFdUii5H+n
	RNrDQn0czjsqajD0WPTjOI/HO7oigEcbcohQcMnLE0GyU2RXIsFCVMHSkzDepLQqxpwGvs7ybxT5Z
	gQCRysEYEkntfts737+oZckDObg0ZvfoDTuR2+M20xEyBr9oaq3+mSNXXI/AHs3koEiIkwwAR59Fg
	q0ZQeCsweA+pGw3HJ5pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWvr6-0000000GF9y-21rR;
	Fri, 27 Nov 2026 13:19:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWvr3-0000000GF9c-2a9T
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 13:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795785546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu+tAJYAg4+65Dcz+qLtk1wN9QKpyo0OAAyklv+UhaQ=;
	b=EQXGQMZfOMgHIEG1CZz42j9WBQ+BfhQeGG7C8F2EGo9wT+ZlfwqN3/0eLggtdL9XG+mLuy
	lEVfd3uhCA9vDyLqj7h3Fc3+IwjPej810jTdzIMVnEM1x5SP18raMq1r2ow88ZmZN+Dn0f
	/mI1NbxDDiOnmU9T4C0NNduZq4RloEY=
X-MC-Rep: binary re single
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-UQMhyZTIMLG2Swij6djQaQ-1; Fri, 27 Nov 2026 13:19:03 +0000
X-MC-Unique: UQMhyZTIMLG2Swij6djQaQ-1
X-Mimecast-MFC-AGG-ID: UQMhyZTIMLG2Swij6djQaQ_1795785542
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f05c68629cso54928305ad.1
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 05:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795785542; x=1796390342;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qu+tAJYAg4+65Dcz+qLtk1wN9QKpyo0OAAyklv+UhaQ=;
        b=Cplj+rhSpTeLrbe73coE1cH/yt8IBY5nEgYzS69ll1kQ9TfyEM5Iymv4dcfADuiL73
         SWkGK9krFU4TYJRPsEWf53TT2GgI5fy7L/NVGU/J5ydBxd5dmXZUQFW9Hs43DQUc4TPm
         Gdy/3dgA6UWwIzFqcLwxM6+mH10ISPY5pBc35qrGs+1iXivwxcegis5YQ7pN8YV6z7be
         rGQRxWifPIE0QJnVkxZPvNMTdc/2ww6xC4VKg78w/8uZcsDHUQmZI8gKpU0antjkADdu
         4ZToYWv1AY1oum4E0fxBQHIIz60P5k0k2zLgRkfuE0I3iaYQAUWtsGJ134RtrhbRLjZh
         Zluw==
X-Forwarded-Encrypted: i=1; AL+hErHLgMrudx4x0I9dBBIkPZvgioN7OjNGfjVaIsJOmGv9hkOFau18t1iwbS3xEna5Zs6I5tirWw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/qTBpUoqNvBFOTmcKa80EjKqCypN9xTMu0LAO61rAW5vXuRDYJ
	FONonZY1BjaB4ozNwiL81FvrMQalw0huusdkEAFoVFcxbk0cjVrCivr2bY2zqC13Chw9eowyid2
	/fEtHpfBfiQyQDhEceU49XFML7kif/QIPan2FZnQgRh8MzqyihkHMRIJBu5o+VQ==
X-Gm-Gg: AZFdTZcwIL4HzalhXYN22Fvfe17clCYWIAt9/C1C2bA0qNCMt/6SvaTgLijjnhVJ/OH
	d6++pymqZ1UhLYHMaiPeZplwyFQyHdhedxOpzJAmP8/Ar8wnzFFo+S0qHqwFkKhyO2Ox0VVbsiF
	O85pWady6AlxhtzmhwIEwLIoXrKW6KkOduBFawPXopwx2j7wTz/vpZB3qSNeVMb8phkHUcCfo4L
	gOUfYoJcm1jS63YVjlVGADpKGvTLiOeuEfLSGsCGZdXt+TDZqhg3Y4qP/DZKeW4ye2rNDRIxqyF
	JX0ZreCTz9jbykyjaVSd8Yu7LsklOK/c+1gT+mknPQGSATYVESrffxpvKcYf61/u6rmVc/SVnPz
	aDH4wqWCgEuVkcnOU24eHr3aZnVrAplIQ8DhPalg5M39t8tV6gqY8IOq+4tPwB/9gcw==
X-Received: by 2002:a17:902:ec8b:b0:2ea:8265:7320 with SMTP id d9443c01a7336-2f03f1ec353mr244470125ad.56.1795785542017;
        Fri, 27 Nov 2026 05:19:02 -0800 (PST)
X-Received: by 2002:a17:902:ec8b:b0:2ea:8265:7320 with SMTP id d9443c01a7336-2f03f1ec353mr244469765ad.56.1795785541526;
        Fri, 27 Nov 2026 05:19:01 -0800 (PST)
Received: from [192.168.1.38] ([59.99.179.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b66sm120837755ad.51.2026.11.27.05.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:19:01 -0800 (PST)
Message-ID: <f4270f12-a1c3-4462-9574-d9fdf2501fb7@redhat.com>
Date: Fri, 27 Nov 2026 18:48:57 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kexec-tools] kexec: fix kexec_file_load fallback error
 handling
From: Mukesh Pilaniya <mpilaniy@redhat.com>
To: Bradley Morgan <include@grrlz.net>, Simon Horman <horms@kernel.org>
Cc: horms@kernel.org, kexec@lists.infradead.org, ltao@redhat.com,
 prudo@redhat.com
References: <AD2F7A1F-3D15-424E-9F3A-6E8D2A937E6F@grrlz.net>
 <a2958690-4d20-463d-a0f8-c1a18f58e286@redhat.com>
In-Reply-To: <a2958690-4d20-463d-a0f8-c1a18f58e286@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IFJa-Pb6-qkUWBzfYlo_onhIMcEiEq7LaGdzgaSsPAk_1795785542
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_051909_741048_DD83EA89 
X-CRM114-Status: GOOD (  22.34  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bradley,

On 24/08/26 4:33 pm, Mukesh Pilaniya wrote:
> Hi Bradley, thanks for review.
> 
> On 22/08/26 12:44 am, Bradley Morgan wrote:
>> On 14 August 2026 08:53:29 BST, Mukesh Pilaniya <mpilaniy@redhat.com>
>> wrote:
>>> With the default -a (--kexec-syscall-auto) option, kexec-tools first
>>> tries kexec_file_load() and falls back to kexec_load() when the syscall
>>> is not implemented (ENOSYS) or the kernel does not have a loader for the
>>> image format (ENOEXEC/ENOTSUP). [...] Falling back on EINVAL hides the
>>> real error, because EINVAL means something went wrong during loading.
>>>
>>> Remove EINVAL from the fallback path.
>>
>> Hiding the real error behind a fallback is exactly what makes this one
>> hurt to debug, so good direction.
>>
>>> Several kexec_file_load() image probe functions incorrectly return
>>> -EINVAL rather than -ENOEXEC when encountering an unrecognized image
>>> format. This kernel patch fixes the issue:
>>> https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/
>>
>> That one is still being reworked, Pratyush just LGTM'd the
>> probe_default change a couple days ago and the fix isn't in any tree
>> yet. And until it is, the arm64 probe and the riscv image probe still
>> return -EINVAL, and that last errno is what kexec_image_probe_default()
>> leaks to userspace (I checked the loader lists in the tree). So if this
>> lands on tools before the kernel fix lands, an image that used to
>> silently fall back to kexec_load() on those arches now just fails with
>> EINVAL.
>>
>> Is the plan to hold this one until the kernel side is in? Because right
>> now it looks like it can race ahead of its dependency.
>>
> Yes, the kernel patch will merge first, then this one. I will follow up
> on the same thread once the kernel fix is merged.
Both kernel commits (b7c94f4d096 and 2792b4b15f) have been merged
upstream from Linux v7.4-rc1 onward, so this change should be good to
merge as well.

> 
>>> Print the actual errno for ENOEXEC/ENOTSUP before falling back
>>
>> Good, that is the part that makes the s390 command line case visible.
>>
>> The my_load/k_unload ENOSYS message hunks are unrelated cosmetics, fine
>> but could be their own patch if you feel like splitting.
>>
> The my_load/k_unload ENOSYS hunks are not just cosmetic, they address a
> misleading error output. Today, when kexec_load is absent, my_load dumps
> the entry pointer, flags, and all segments, which is debug noise for
> what is simply an unsupported syscall. Similar, k_unload prints "kexec
> unload failed: Function not implemented", which reads like something
> went wrong rather than the syscall not being available.
> 
> I'm happy to split this if you'd prefer, but since they're small and
> directly related to the error-path cleanup, I kept them together.
> 
>> Its a good patch, I just want the ordering question answered first.
>>
>> Thanks!
> 

-- 
Regards,
Mukesh Pilaniya


