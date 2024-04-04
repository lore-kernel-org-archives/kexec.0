Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D480CD1292
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ec0w8LUTftOJO8zahn9bitZ2N4TRfjn+/6BS1xMyi1k=; b=YPxJ5HAkRYmKvv
	u3UbsH/xd4POkUc4+avtfo4N6jYThzgzoDg9J7bzW+CGNsabBXJ6gVNU1GB98SDtBVkPS3vEaijro
	SURzN5Yb0FzX+cLDicA63hT8w4D2qFE4rYgkacNlzodP/qkyKrThqmZclYPosloR1Oz1rQS9OAPF+
	Klpg4ubW1+yI7n7OLzJymWcE6XrSmgTU/NaqYwcI0kGXuSQcXIS9ZgMfvaLvM19L1qWP0X3BWBbkn
	pqAPiQ8qTFTlf/OEkPgHKJKEKYmeeWrWiaVUrdiCrNpw8dVYM6qWqZ6VnAkYst3inoX2HjNa1iEPU
	KiKptHWyDC75ZjR4sktg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsUVj-00000004Ibg-39vJ;
	Thu, 04 Apr 2024 21:20:39 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsUVf-00000004Ias-1OxX
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 21:20:38 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ecf406551aso756329b3a.2
        for <kexec@lists.infradead.org>; Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712265632; x=1712870432; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=JikOE33Ay65xVIe725Xg1q+a8xk6DVGwPtx55sRrEkihwwZFIDqqfEy0DhQqqaSDhE
         V+9xQOt7216/x8Qus8rXfZdH+kGjvGA/CgA9FdzbPOS+4/413oJ//lDj1fvwAKcPS2Bu
         BROQBzn1MWwaBv5HHRZUWOFx3tXbKYtXXWHDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265632; x=1712870432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Or6NstpRZDX+9Mk41p2/RZwAVxHZ+F1Exhs3xjDok=;
        b=jQ5B6OsH7WJQM+ZzK8dfkp5FXeagM5mKpCVouM76oO/4gixS/jHIqw5/4JBevTy9lB
         tIQapzAGYcbz+cX2USix8PPvSFdRswUfdMYuOdQijb+vso81L897t9PLLbtEKKwK7unm
         vfPdcHcG8sLJu/gqRtkEiG96Vs+iOqtq8j8UwwgmPuzZl8N2rJJsIa7CnOUCNfNi9W+2
         Dmu8nypGF+ca+vYe7wdxy/7nt6TSf5iMWWIb/ilQkDI2Eh6MN2lMuuqJf0uNLaGS4GXe
         39wxTG7ptMj6dN2TGBwRSN2329x/UaXIyc50OHe7HEkxt3UvMClhxdOROQNm4VY/g1FB
         mR7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnwn5UnEyuyxCYCiFXjc8MGEJVSf5XgHUtXTOuo437tgBcOxzCCe6EMDbn3NkZYEUN3MaGFVJaYwcQS0xOKjAxRfHpzOsxW342
X-Gm-Message-State: AOJu0YyhVExsJCiFjtI6kIQcbaKqv4AQgXqPsm/YKYxYZ2U1UgEoDnph
	/A7Drt9D/Rwi5Ds/HeZNaLFjfFGSSVaO+0LzJKGyEvQJ0SQgPjxLC/rIQDPycw==
X-Google-Smtp-Source: AGHT+IHM9ahEcWXLsBaMCLEHnLx24RdcbgqVAPA2u0PCEKRr8KtBpytL1lmSDOlyFf59XcyE6D7u2g==
X-Received: by 2002:a05:6a21:819b:b0:1a7:35b1:18af with SMTP id pd27-20020a056a21819b00b001a735b118afmr964578pzb.20.1712265632210;
        Thu, 04 Apr 2024 14:20:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e042dc5202sm79451plg.80.2024.04.04.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:20:31 -0700 (PDT)
Date: Thu, 4 Apr 2024 14:20:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] vmcore: replace strncpy with strscpy_pad
Message-ID: <202404041420.E3C0933@keescook>
References: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-proc-vmcore-c-v2-1-dd0a73f42635@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_142035_434929_BA07E197 
X-CRM114-Status: GOOD (  14.56  )
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

On Mon, Apr 01, 2024 at 06:39:55PM +0000, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated [1].
> We should move towards safer and less ambiguous string interfaces.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we see that @name wants to be NUL-padded.
> 
> We're copying data->dump_name which is defined as:
> |	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
> ... which shares the same size as vdd_hdr->dump_name. Let's make sure we
> NUL-pad this as well.
> 
> Use strscpy_pad() which NUL-terminates and NUL-pads its destination
> buffers. Specifically, use the new 2-argument version of strscpy_pad
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
