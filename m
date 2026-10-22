Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808A606A31B
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U/+nTijQ;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=aXIXm0Cf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KdgvyfyGLF6xVqvT4lRhkOaHE+7q7+9ylmI+jmCxxss=; b=U/+nTijQZ1fT2B
	haO24JudCNPBDdqgfNYxnNSRllX78auJT6NeChW9MiQg6Nvj2Nej7jWRyBcQJ9aF/s1LK5lB8Zz3B
	v7F/r0vbzSpLucmJmBJ3UG4MVFcLNNnok5+6fpA2DRg2ELX85UxwzIzIbiyUOSPIwhOA38ZAAqhP9
	qBoW2y1O/B86Qf+ryxK++2yXl6NBqPIL5Z7BVRgqytz5FczDyUUBHCmj9yYoPTNQHEqLZLEg3a13O
	L7EcKKoOzgsdGgKlQRNl3ZRwRrBC9Yes1bQDxO7Pcy1GRpRPJ9+OcQfPHjJdByZE9Od7ucaZJqsaT
	0w1EsUeceesqG+CNb00A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJvkR-0000000EV7v-17er;
	Thu, 22 Oct 2026 16:34:35 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJvkP-0000000EV7U-2FLh
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 16:34:34 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2434553a12.2
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 09:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792686871; cv=none;
        d=google.com; s=arc-20260327;
        b=cgm+w6tSTlVADbNRj1SQy4XkxeFMDMReMYhyz+x8idghk31m+gU/NOZvWB/ptDsmZQ
         SPEzwNrVcsnExV6KH2bDyUub9loxPurSDls/lJUnYe3dTOFlhBzYj5Od7Tj5vaxmrAOA
         ClNrSzvRXDmZJnXNDs7iKjIrKeBvEajNrnKyu6saqRrCT0FWJZep+gaGVhjlS/2/LVZ4
         Wc41aPG7wnogitz3VeeTOqCXXHIEOxPtZAAPTCYOGhzssKrFaTvbpXqWVul7abDInkHG
         6WMgBAkraKBG8W1K786ROz96TinxpBDxsyK4nikZh6jAxxyAxJD9A2YEE88hWAQbEUMT
         Oztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KdgvyfyGLF6xVqvT4lRhkOaHE+7q7+9ylmI+jmCxxss=;
        fh=jUc/kpxVhdasWMuKCPLg606/7ICJnUKjMaIb9NyMXrI=;
        b=MU0EgjsD6mFVIUrXbQzpOI465GjwyDHOLL7mEDb9cx3L3DSuS7b+xncH637bvPQckf
         hhXHelJHa8MFUOlrnb5T7GGMPfV1BxMJci8wdfa49FQgbn4ZxDBuVkLbpu9c7Wmkp8CY
         LRD0SgdCmse9skjEKQx9EcWLo8REXb4n5OYY0mszlgiQ5rhYGSBJYRj37tkD0E9iIJti
         Q10o9XE/XDBV2B+0ZhTxRsvkjNKIf+6Gsjwf66jVEbMayGexPGinSU4briAW53EAMLk0
         RIedb/5B8YZ4krn8vJsFLSIKVq5pa+wBPkqWLLUn/FP0tSw9Iqb7lQRcIr3zl+rJ3KoV
         58BQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792686871; x=1793291671; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KdgvyfyGLF6xVqvT4lRhkOaHE+7q7+9ylmI+jmCxxss=;
        b=aXIXm0Cfi6lVi8e4RQQJblqaGofE34icGgJnqIo89SIRg+IdVjP3grBAXHpRJ15T6I
         1L9hfmsLXuj6+2I16OiWcRWAFvFRFcHBD/lRUHUOWT5lCWTJJ3C8P1XPPBrKQ9Kqr0jt
         B0n7UW7SW+TZLalwGTqOlqMhmBkuBPK0wGZa+Rr80K7TMrQfSFDODLXrq3LOD8uDfBYS
         QPIoAS3TvXb5UgntIxjkuTPGilCN1m6Uiyh5If8nDBDwkwq+m9Ks0vV0VLMLjAXUJUh6
         BY1plYVL/yyl1zDDD5vmrfREq+ARkGlLry6gEv85J13Es7pQpmoOS4pLjTtbwubiApQb
         UgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686871; x=1793291671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdgvyfyGLF6xVqvT4lRhkOaHE+7q7+9ylmI+jmCxxss=;
        b=ETfuX3x4no2REwpgV+dKV3GcbBY4wwbkxJ7vG+dm7yTF2ELCe7IkxrENbelreGoysA
         b1chCGIfqGcRP7KuqSJiVRpLQdBkb4G5yUin2Vmo94+TdCkjew08lKRHimr1HiflLSWd
         Z7xoZk5/gWb6gZjECaOVw9+4zkrwqgWkOXA5cmou9GDfYrldbPEqEZC0tHxj5MaNm2CD
         pEIvlIx62EjFLx7HCjv2Bca5Bq5c/+1ZpkHZPzI7g4V8stpuUI6/JRGolXj+KrqY2oK+
         z+JLUSdZ8Xkgj44Jy4eJW3hz4KMtDQr0FH9EX+5Yc0lnmWfIdYn5bCtR0JyM6Frr69xU
         s8GA==
X-Forwarded-Encrypted: i=1; AKwUvBxQzdfT35jIwgCF6pOe1HO8S5NSqu+AdYY3cQUEhsWO9uLcfHQy3uAQcyrkuvliSD6K5/puMg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJQGvth13zrs7oICVutmmoB9BCl6+BXsSXWRohUQO11mKtlJBqb
	x9YbUhaqItiO4AuGd1kH+Nh6kA5gEqRoaqvD5zElmcXdz8zCX3Xm/q0jEeQYY+uxv3f5ow07cOQ
	mTsyqSV8gUWwmtXAxHrcHqXmFfL+z1yLAQPicK91nE5+rbbMG0XdVAII=
X-Gm-Gg: AYBFou32NTJzndXEVboigU/3MV11en5V/AsS5kqJpXuV/ivjfvuxXRj5QepP/0F0EfE
	6Wbd1r31R3nN7qh+fDvbrh/1QmJ2RqzCdm/+yK9GVO5CPQJM80vXWuWiQ9XxkGplgkyQnJq6BK3
	aUDaPEsD+0WvtKMgUvexf2cNpqgX3YaUEOwYhrNN42dGVpEhz/HJn0rojQgMIlwamouFXznTfR+
	+bk+ONylVaoOo212/rG0u9tx5wWhQ9AoJ18qHv1oyIj+2xfSJfe1GPeVu7vJaT2FOuJ5KKhrhJ/
	DrURZVgJPFxx5dgXkLfZF1GNzJJsRk+IibUlUiNbQQTSJXHZQCFcf4lRx59p9CBVjmkbL81vf+m
	nDFwl71x/SSzvGbdDXgnfCMJzydkcXyWX6T/4qotlaEJNlvSS6dqur7H2Bjv5xQY61WxI
X-Received: by 2002:a05:6402:21c3:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b408e97bc7mr4806912a12.9.1792686871349; Thu, 22 Oct 2026
 09:34:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015020313.946940-1-pasha.tatashin@soleen.com> <87y0bp20pn.fsf@trenco.lwn.net>
In-Reply-To: <87y0bp20pn.fsf@trenco.lwn.net>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 12:33:53 -0400
X-Gm-Features: AclHuK8Otm0xJpYhkHmHhBvYvdF9NjZJWWHbtCPr-MhhnCbHqDLRJoujsYa2diA
Message-ID: <CA+CK2bCj9mSc5xu0B3QtxgRd=P1fo910pO_fx6f5o_Wu2YDTbw@mail.gmail.com>
Subject: Re: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR() struct members
To: Jonathan Corbet <corbet@lwn.net>
Cc: rppt@kernel.org, tudor.ambarus@linaro.org, mchehab+huawei@kernel.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, aleksandr.loktionov@intel.com, 
	kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_093433_602598_95B1DB71 
X-CRM114-Status: GOOD (  15.20  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:51=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > KHO ABI structures declare their preservation pointers with
> > DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
> > and its physical address. kernel-doc does not know the macro and does
> > not see the member: it warns that an unnamed member is not described
> > and that the description of the member is excess.
> >
> > Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
> > for DECLARE_KFIFO_PTR().
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  tools/lib/python/kdoc/xforms_lists.py | 1 +
> >  1 file changed, 1 insertion(+)
>
> Applied, thanks.

Thanks!

>
> One note... these:
>
> > base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> > prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
> > prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
> > prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
> > prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
> > prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
> > prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8
>
> ...make b4 go off on a wild goose chase and caused the application to
> fail.  They aren't prerequisites at all, I'm curious about how they came
> to be here?

Sorry about that. I had this patch as part of a larger tree with a
bunch of dependent branches, and I generated it with "--base=3Dv7.3-rc1"
without first rebasing the patch onto v7.3-rc1.

Pasha

>
> Thanks,
>
> jon

