Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38302C77B75
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onOr2OcVtB0yGKJgACnxaVXekdXBgE0VVMpr7YzM1kk=; b=RmS2m53przKlrQOfePe2XwRSGC
	youGhQmJPTTmrWHDvwDTfwukk7nrJgyE1uWCmlulEA8+IUbuoMbjef6ZPOVvj4dfeROydwVg3mUqZ
	II7PMit4CSdoE2MHBfe6r7zGf/2i9ebak1UwjGUaZkFQG0Vvp6Ywo/l+k5MPBEMNlTzNU7isR7ZOI
	ox17SUCLjWQSLK5K1PCtqr5jOjWjwp6s5nb+BT4ppx7OxypC+ssy9p9CB5IEDo7H1wi4hy10KrFbA
	g2OSF9WbijVyRlH2UYnT9kbA8Al6ArHDsGVD/ibmMEfNH31dbFOUtKv2NcrV8lDdzOFYW/gRKO0wg
	PR29wPcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXgK-00CjP9-0i;
	Fri, 12 May 2023 18:39:56 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxXgH-00CjOm-1r
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 18:39:55 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf702c3ccso509375ad.1
        for <kexec@lists.infradead.org>; Fri, 12 May 2023 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683916792; x=1686508792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxNeqg6Grq2YNGnd0knd3lPwc/gWH4WprNL3yZRCSlc=;
        b=lp1Oy3BhdQeeC6JznyjC8cBtFOeNbflFpysHr1GQrN0z/RDcUwp19X8dIn53f44vUU
         H6iorDT8qheOoQg95Fu6GGi2b6yvR5MviYTnbz2V7XHJkGJBV6gsqCJRm3fqOkwHQAnH
         ShE6LHl4PKFR+g/210rb3bjvWRSlBMjSPomzjrvTXlqYyGud2RYS0DB1w/u6mJAlPq+K
         olPKd8cPOmPVrMHiWMXqvvY/x/JzSid+UfiuEo/l/PJ/cH5hyaZn+fgCcrSmxUbTqteB
         3DhYxfh+iVRcv3HeKAmRSVq6ZPJ0uU4rT9GO5+vLPcvHUBFo1aVN4GSNzLvp6Zs+3ojy
         s2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683916792; x=1686508792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxNeqg6Grq2YNGnd0knd3lPwc/gWH4WprNL3yZRCSlc=;
        b=VY1evRPfQg0lorCndmSNXky8Xho6DckKXucukXStt6EXYm4OsX/PckV8s7fqKXikbq
         UjO+ScWnRS9rLStVj1nE3XHQCNNwQR7p9UsuUt0XQSs6Bwxz7p38Ki2r34AYkNZtXGiD
         qWZfN7HN1Qxip/QA1KSMVxq+OsqdHJQ+gbYeigpnouxtUBBR34u+PT9I4WpgmVSbN0nA
         yzmUdgDGrKkFtXklzaOKehjQjzyVOLow5w60tCKNjuacRVabCV2lvGnkCB0cY2dWv1Aw
         gzHN/F88BfFLNIlFfgQ+Co2FvUr0KS3uazOTUg2oXzQDo7mLHB0aNMWKol89rW/yvRE4
         muyA==
X-Gm-Message-State: AC+VfDyy5utJrgPPHBvB7DdKStZ5j2iOHflSu2SVaALzOCrNEiwba2Yj
	vFlKgH+1zrkH7/Z61SUAX73biA==
X-Google-Smtp-Source: ACHHUZ6aomZXGlc1Nc6ucUjpY7UMr453DjWUnt0izCabu5fBIrS8LJlevVdVes9dZNx3ZSW0bw23jQ==
X-Received: by 2002:a17:903:1cb:b0:1a6:6a2d:18f0 with SMTP id e11-20020a17090301cb00b001a66a2d18f0mr271059plh.9.1683916791741;
        Fri, 12 May 2023 11:39:51 -0700 (PDT)
Received: from google.com (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b001ac618a6d55sm8215718plx.242.2023.05.12.11.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:39:50 -0700 (PDT)
Date: Fri, 12 May 2023 18:39:47 +0000
From: Fangrui Song <maskray@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Message-ID: <20230512183947.jvaslvmuhy7gndix@google.com>
References: <20230512022528.3430327-1-maskray@google.com>
 <202305121126.E5AD334AA3@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202305121126.E5AD334AA3@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_113953_618065_035D8D4D 
X-CRM114-Status: GOOD (  17.72  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2023-05-12, Kees Cook wrote:
>On Fri, May 12, 2023 at 02:25:28AM +0000, Fangrui Song wrote:
>> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
>> header as an array of 4-byte entries or 8-byte entries. Currently, there
>> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
>> it would be more appropriate to set the correct alignment so that tools
>> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
>> well.
>>
>> [1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6
>
>The interesting bit from here is:
>
>  /* NB: Some note sections may have alignment value of 0 or 1.  gABI
>     specifies that notes should be aligned to 4 bytes in 32-bit
>     objects and to 8 bytes in 64-bit objects.  As a Linux extension,
>     we also support 4 byte alignment in 64-bit objects.  If section
>     alignment is less than 4, we treate alignment as 4 bytes.   */
>  if (align < 4)
>    align = 4;
>  else if (align != 4 && align != 8)
>    {
>      warn (_("Corrupt note: alignment %ld, expecting 4 or 8\n"),
>           (long) align);
>      return FALSE;
>    }
>
>Should Linux use 8 for 64-bit processes to avoid the other special case?
>
>(And do we need to make some changes to make sure we are actually
>aligned?)
>
>-Kees

64-bit objects should use 8-byte entries and naturally the 8-byte alignment.
Unfortunately, many systems including Solaris, *BSD, and Linux use
4-byte entries for SHT_NOTE/PT_NOTE, and changing this will create
a large compatibility problem (see tcmalloc that I recently
updated[1])

Linux introduced 8-byte alignment note sections (.note.gnu.property) a
while ago, so the ecosystem has to deal with notes of mixed alignments.
The resolution is to use the note alignment to decide whether it should
be parsed as 4-byte entries or 8-byte entries.
I think that just setting `p_align = 4` on the kernel side should be
good enough:)

[1]:
https://github.com/google/tcmalloc/commit/c33cb2d8935002f8ba942028a1f0871d075345a1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
