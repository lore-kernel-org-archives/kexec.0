Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B36C531C9
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FftrUEk4ZkE1WXNTNenEBP8mAR3bbgckW3kBU/PXrbc=; b=jPjGkLQfEC6gHzTspe8mGRv76F
	AjJAVG4IGsk+dc3sO9aOf96LCd8j7Fm+YDb7KnKUMmq6tMtNDA9yl3/sGGkhx7oFEr+I4ESeCLNmT
	F+XoQ3YZv56mx0gri5DOsKpjIsbMp/KDjeab8oR8K7SrxkQZIJP0Gton/XMfJKMPmIpKj6pMUhTn/
	DYpzx2rjYPzwTxy0YP6Sc6hnSaE4TCTkXiKRHVbGZTllbiOvA7Ulduz8YMIJ/R9L1z7lvYd/O3eSs
	onwQnTyyqeODfHMYF9tm7Q3SLAuQ3ypnp+fndCbuGdJC5l4mlvmpzDjU3yKoa0L2prW1dw8PGBS+1
	qGmoe3ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ2I-0000000Gs7L-2Ycu;
	Fri, 24 Jul 2026 16:46:10 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ2G-0000000Gs6n-1ech
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 16:46:09 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8f0e5e36912so5512166d6.2
        for <kexec@lists.infradead.org>; Fri, 24 Jul 2026 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784911567; x=1785516367; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FftrUEk4ZkE1WXNTNenEBP8mAR3bbgckW3kBU/PXrbc=;
        b=iGbWDhKReIrLpBRLSfA7isJ2sCGYgbVFC8GzT5ewkEVCA0DXTxHhpodPp5QuSZZ6Ps
         5Zd296sas9rTYJgk8Ws/GAa/zL4aWQ2tguw4mH3DPoJgXavJoSkikXxiPbBJreQtwghj
         52wSDPBwtyEDrtR8I7PRLSNQAFYw8f8LC0xio+wx8/ynpzvrWiqybwmjQLiGg9meB8y6
         LzQTwEsSGTkCekVhWzeuaLx2KwTKOLusPtO9p+NAzv3GJ1JpJcBDnQfvYH/+cd/ClcQL
         oHCTZQ6qETJxYekp+HVO3ia0/2VYm6pflD0cgZlfqod9bjCYPwvHOtnR38+psg0MYtYr
         d3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911567; x=1785516367;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FftrUEk4ZkE1WXNTNenEBP8mAR3bbgckW3kBU/PXrbc=;
        b=Q0AXHcdjZ7w6htH0a3UUw45g5LPziVA4EqDPJKN25X/ANQ9At6UQP/ZnWfCe7l79bS
         QGbm9Olk4rfBpmI5SnsMGrSuSNT5d87dVaKZlngY++lsk4EbDr1OLczQvE0QG6bU7i7W
         Z29kG0IxY/RurbDMOIwjrM99QgeVCcn/6GcrAiojjMv+qQE0sPYc8+zecsTjZW0VUDx9
         tuq9B9mJ3lCpzIi/oiMjO6QyDpQAvWLtuYN13GUIcfnwVleJU6loICLtRpMnCWJ0+5pt
         7nAH1zO9c7DWS2tR27ikP4/uhqZ5VUhAr+3D9H4cYVK3vM+HVK/ZFzuvO4AKH0Et26GF
         G3bQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbhxFmh/1GYJUst7mCGFqFpeBRXaaO7a7fyVdSR6jjmKukilRGkiB37POC2/0sMruYusZvng==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0YiCyQdhJYi6242b6cJtFhkKqiWmx0VfoKYTyBZ22ODqA9Fjb
	92ElonFOl3g2EiEEOU+EqpVyady3HK8bcLEW2+mFujdLnx4Rt1r+I5S29qj0+tCEXPk=
X-Gm-Gg: AR+sD11fgI6P6AEsgow29VfxaSH68xxD/CYvam5eAOZiMbbYtamMToD8k4M4EGl6xzN
	Wn54gGmO4u49pBf+7Dhu3fFsIYmU8qz6Db1k4470bmoT7auBWG/9bBM6fCzAbmgyyr+fByL6BKL
	oQGNEjU6zDiblWqkB0br5AYoTr0hehdar29ccZAoe0Gw2Xssk1KeBCRJGx6toqOps0WAXsyqLHr
	QVsZa0dYXS3CE9WpHo/SfehomtJ1TyhAhExnAYMhql5RvueUNfSNpSQuSNwYogYz2JGPRMe9guB
	gcXxtHMG+t6tqAwUacK8Z1RK/2WNJ0h54AQvNwqzlet/6+CRoy4CeMkJH+5KVM668LCRJscQgWj
	UWvptUduwirCzzPjZ3lLhOipf3GSQ7OftYnwGazF3xPsvkSiq7XTkMlSitfI1DSEH1o1i/eFmI+
	29+kZjbD1g9JzJis18itrtXd6nQK3Mblf+oqZUBF0Z
X-Received: by 2002:a05:6214:f0c:b0:8cc:de2:3b5d with SMTP id 6a1803df08f44-907ca5734acmr98718436d6.16.1784911566647;
        Fri, 24 Jul 2026 09:46:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e851ec5esm1986286d6.10.2026.07.24.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:46:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:46:04 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, skhawaja@google.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] luo: Update serialized data to use KHOSER_PTR
Message-ID: <amOWTew3JpsY4QcB@plex>
References: <20260628001114.1869564-1-tarunsahu@google.com>
 <20260628001114.1869564-4-tarunsahu@google.com>
 <178271651966.13502.2620034351625890943.b4-review@b4>
 <2vxzldbklb18.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzldbklb18.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_094608_452696_8483AE65 
X-CRM114-Status: GOOD (  25.78  )
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

On 07-09 12:20, Pratyush Yadav wrote:
> Hi Pasha,
> 
> On Mon, Jun 29 2026, Pasha Tatashin wrote:
> 
> > On Sun, 28 Jun 2026 00:11:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> >> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> >> index 288076de6d4a..9e78625cfdc1 100644
> >> --- a/include/linux/kho/abi/luo.h
> >> +++ b/include/linux/kho/abi/luo.h
> >> @@ -89,14 +90,14 @@ struct luo_ser {
> >>  /**
> >>   * struct luo_file_ser - Represents the serialized preserves files.
> >>   * @compatible:  File handler compatible string.
> >> - * @data:        Private data
> >> + * @serialized_data:  The serialized KHO pointer for this file
> >
> > I am concerned about layring violation here.
> >
> > LUO is designed as  a generic, opaque transport layer that promises to 
> > preserve 64 bits of raw data. How those 64 bits are interpreted is 
> > entirely up to individual clients.
> >
> > While some clients like memfd_luo will use those 64 bits as a physical 
> > address pointing to KHO-preserved structures, other clients may store a 
> > generic token, cookie, index, or non-pointer status. By
> > changing u64 data to DECLARE_KHOSER_PTR(serialized_data, void *) in 
> > struct luo_file_ser, we force KHO pointer semantics and layout 
> > constraints on all generic LUO files.
> 
> That makes sense theory, but in practice, no file handler is going to
> need only 8 bytes for its metadata. It is always going to need more, and
> to store more information, it needs to store a pointer to that
> information with the 64 bits it gets.
> 
> Do you have any examples of something else one might store here?
> 
> At least looking at the current file handlers merged and in flight,
> memfd, iommufd, vfio, pci, hugetlb, guest_memfd, all of them store a
> pointer here.

Right, and all of those types are private to file-handlers, not to LUO, 
so my question is:

> 
> And if everyone is only storing pointers in this field, might as well
> give them a bit of type safety.

How khoser helps void * type?

Pasha

> 
> >
> > Clients that need KHO pointer serialization must cast that opaque 64-bit 
> > value to/from a  KHOSER_PTR  within their own callbacks.
> >
> > Also, the field descriptions in  struct luo_file_ser  are no longer 
> > aligned due to the length of the new variable name, I believe it will 
> > cause warning when making docs.
> 
> -- 
> Regards,
> Pratyush Yadav

