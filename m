Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59645CD6E4A
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9XIwGoHI7koXT5NUKG3hqbl2ARW9TxartU/PZHOXcY=; b=R2GNPYR0kqZ84SsdJ/CuEkW4bm
	s0zCAh8ggs9KPdrdFZdsgxkTtu9hNgZA/h4PNVdqisV9a/XrF54jO28JLjm4Po5EAYHqLu7sl6qYo
	MkHBPXXqNO9D3ZvHb2Exxst+24x8RL5pBiF7HhuOLEz3oriqOFQDQ4Mk1iSLKYQoJKztIdZujVSLM
	iSvWfdoilbiuZoMHmbkipu/uBP4zZ9A27/mZuM22NWrQRmxO/36vXac7eoloqSivwL6EghW3sBhUT
	r7mtzRoZS5CXXTxR721mOI4kzYpWty7yi1+puZ2gkRvoXjzFTAyy+w6FolkvcP8L9FyD4cjNVCNKW
	i3h/WRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSgnt-00000006Ir1-1RO4;
	Thu, 28 May 2026 19:54:05 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSgnr-00000006Iqf-0zg4
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 19:54:04 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-5148cbdea08so108817361cf.2
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779998042; x=1780602842; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9XIwGoHI7koXT5NUKG3hqbl2ARW9TxartU/PZHOXcY=;
        b=FczchCDd/17rhujGWEoIols/OvVTJnx6UxTaTSK2+1oB9iF8NIZQuL4q4qv5SmZquh
         Xp8oDDVz2b3Nu/CfTp24ffZj4lRRE82Ek1HC0RZ26hxI0z3BynebkQaYho1i60YEww9r
         e/sE3wKgf9x9AHYX6xeYkcWAsctembneS6bGz4+gKC3+0SJJS0hgKlnBjXEa+xabb3K5
         ar+E7MhPUldw8QckW3g12bOCZGbJytdOGALrat6RfHPDppM8cCfzKIezbYjytVcavi3m
         rygOnFvMUSoKre/kquVA8DutHiplveksTrj+Rx72lUZ7pZoxm0fv71uGx0k7Y3NcvxuX
         Wr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779998042; x=1780602842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9XIwGoHI7koXT5NUKG3hqbl2ARW9TxartU/PZHOXcY=;
        b=ao8OElETX6FCY51mJ3rxAr0kSFi3hciz2VxJsrcQIizbe9F8YaNe0zCiYy8KGJvmov
         jcF2SEud8fWeV5S4rqEcfkb4Ylkec/+yfC64S7peGKx0OJTfLaPBTMwV2Vm/3VkEf6Wu
         NwZHT1+2N1nimZoQyqVqyXss/DkflgIzOkbW7jm9SZr/8CzPcTWYRQxZVYAD9PhzWmCL
         vl42eej0pXwSwXJp2BTpJdGoc0UB0F3PoHxuxAdA3qxtPWc0pT7h0gEqXPYLh9pxR6Wm
         qOxKLw5yy3OIn+mUjgns/mjr2qbgWwKBOfUG4SZB9TDEacbjQAp40y+iZyNTxF5oJfvh
         duQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uS6k1/yD72p3ewWUEHgsYXLuUjw1nGjAFTw9KnuYJqVEi1lQ7VmsIYpOGXLSYJ48Kdmo97Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1jIvdd16wTMSOuX7R3aL9UusfNh+rQWR88ru63NPF5cKXzxil
	i5Se792paxnZ9wg5CdCnC8YQZH5A1uer7NdWQcjcU28Q24pSDhbDl2PN7RnJEua8kKg=
X-Gm-Gg: Acq92OGBDfmLm6xIutXhNhe2hq7kR/2Z6hV3KfcJ6eKOEbrXhMXXtNSOJmUPo3nSU1h
	TLYiQ4ZI2B4605Gu30kxeupPOHPyt797iC7SyTGE/4biVrjCwSxdmWVHkGXjkR2WNJ+Rz96AbZo
	laOu7Cd8CtWpcdc0ZhbUgnk3ijsqKY7ILeXHOTNAPW5Hksxg7i4JMuwtUvbRtBoGNlrKtZuj17b
	glD905UoAAnqTk6q0wFQZ+l1UXtFf+rIPL8aEWXrCEXeOf3XRVH54YO54aLbSTnWRFl8r4uat1Q
	7cWanXUaPMNMaf4nwO0vEgalm/VOsXltGfZpAQ46DUdYbzTOT2Xf0rGOnr6tURQgaVITq5gcKlv
	04tbSZ4HcD2aZe0U9F1iDseEu7hYBdZdA6lbR1NaWqE51CTKgGGgD/GXMnolrrXDAyxVqTpLPtk
	65aPBNjseRSHxQCf+UUym3DpJBTN9NUBXaPUQfjcjOUuy5JIs+DFV5oH5FYJN/uQ==
X-Received: by 2002:a05:622a:6202:b0:50e:5cc3:6f42 with SMTP id d75a77b69052e-5172cca732cmr3748581cf.59.1779998041630;
        Thu, 28 May 2026 12:54:01 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc63dsm85233251cf.16.2026.05.28.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:54:01 -0700 (PDT)
Date: Thu, 28 May 2026 19:54:00 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v2 01/10] liveupdate: centralize state management into
 struct luo_ser
Message-ID: <aheB1qJbwyGhQ5wj@plex>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-2-pasha.tatashin@soleen.com>
 <2vxz7bor78zw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz7bor78zw.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_125403_321879_CD6B3F06 
X-CRM114-Status: GOOD (  35.86  )
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

On 05-25 18:24, Pratyush Yadav wrote:
> On Thu, May 14 2026, Pasha Tatashin wrote:
> 
> > Transition the LUO to ABI v2, which centralizes state management into a
> > single struct luo_ser header.
> >
> > Previously, LUO state was spread across multiple FDT properties and
> > subnodes. ABI v2 simplifies this by placing all core state, including
> > the liveupdate number and physical addresses for sessions and FLB
> > headers into a centralized struct luo_ser.
> 
> Makes a lot of sense I think.
> 
> But nit: this brings about a semantic difference: now sessions and FLB
> serialization format is no longer independent of LUO. I think that makes
> sense but can you please spell that out in the commit message.

Added.

> 
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h      | 91 +++++++++++---------------------
> >  kernel/liveupdate/luo_core.c     | 59 ++++++++++++++-------
> >  kernel/liveupdate/luo_flb.c      | 65 ++++-------------------
> >  kernel/liveupdate/luo_internal.h |  8 +--
> >  kernel/liveupdate/luo_session.c  | 57 +++-----------------
> >  5 files changed, 93 insertions(+), 187 deletions(-)
> >
> > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> > index 46750a0ddf88..1b2f865a771a 100644
> > --- a/include/linux/kho/abi/luo.h
> > +++ b/include/linux/kho/abi/luo.h
> > @@ -30,52 +30,25 @@
> >   *   .. code-block:: none
> >   *
> >   *     / {
> > - *         compatible = "luo-v1";
> > - *         liveupdate-number = <...>;
> > - *
> > - *         luo-session {
> > - *             compatible = "luo-session-v1";
> > - *             luo-session-header = <phys_addr_of_session_header_ser>;
> > - *         };
> > - *
> > - *         luo-flb {
> > - *             compatible = "luo-flb-v1";
> > - *             luo-flb-header = <phys_addr_of_flb_header_ser>;
> > - *         };
> > + *         compatible = "luo-v2";
> > + *         luo-abi-header = <phys_addr_of_luo_ser>;
> 
> While you are at it, perhaps also get rid of the LUO FDT entirely? With
> this change it only holds the compatible and a pointer to a blob. Might
> as well move the compatible string to the blob and use it directly. Do
> you see any benefits of sticking with the FDT here? We have already
> removed it from memfd for example (and AFAIK the upcoming PCI and VFIO
> patches also do not use it).

Good idea, let's remove it entirly, I am going to do this in a separate 
patch.

> 
> >   *     };
> >   *
> >   * Main LUO Node (/):
> >   *
> > - *   - compatible: "luo-v1"
> > + *   - compatible: "luo-v2"
> >   *     Identifies the overall LUO ABI version.
> > - *   - liveupdate-number: u64
> > - *     A counter tracking the number of successful live updates performed.
> > @@ -109,13 +82,26 @@
> >  
> >  /*
> >   * The LUO FDT hooks all LUO state for sessions, fds, etc.
> > - * In the root it also carries "liveupdate-number" 64-bit property that
> > - * corresponds to the number of live-updates performed on this machine.
> >   */
> >  #define LUO_FDT_SIZE		PAGE_SIZE
> >  #define LUO_FDT_KHO_ENTRY_NAME	"LUO"
> > -#define LUO_FDT_COMPATIBLE	"luo-v1"
> > -#define LUO_FDT_LIVEUPDATE_NUM	"liveupdate-number"
> > +#define LUO_FDT_COMPATIBLE	"luo-v2"
> > +#define LUO_FDT_ABI_HEADER	"luo-abi-header"
> 
> Nit: If we do go with FDT, I suppose "luo-ser-pa" (or "luo-ser"?) would
> be more descriptive?

I think, this is a good idea to remove FDT.

> 
> > +
> > +/**
> > + * struct luo_ser - Centralized LUO ABI header.
> > diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> > index 8f5c5dd01cd0..7ccc59981297 100644
> > --- a/kernel/liveupdate/luo_flb.c
> > +++ b/kernel/liveupdate/luo_flb.c
> > @@ -159,8 +159,8 @@ static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
> >  
> >  static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
> >  {
> > -	struct luo_flb_private *private = luo_flb_get_private(flb);
> >  	struct luo_flb_header *fh = &luo_flb_global.incoming;
> > +	struct luo_flb_private *private = luo_flb_get_private(flb);
> 
> Nit: this doesn't seem to do anything. Is this a stray change?

Removed

> 
> >  	struct liveupdate_flb_op_args args = {0};
> >  	bool found = false;
> >  	int err;
> 
> > -int __init luo_flb_setup_incoming(void *fdt_in)
> > +void __init luo_flb_setup_incoming(u64 flbs_pa)
> >  {
> >  	struct luo_flb_header_ser *header_ser;
> > -	int err, header_size, offset;
> > -	const void *ptr;
> > -	u64 header_ser_pa;
> > -
> > -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_FLB_NODE_NAME);
> > -	if (offset < 0) {
> > -		pr_err("Unable to get FLB node [%s]\n", LUO_FDT_FLB_NODE_NAME);
> >  
> > -		return -ENOENT;
> > +	if (flbs_pa) {
> > +		header_ser = phys_to_virt(flbs_pa);
> > +		luo_flb_global.incoming.header_ser = header_ser;
> > +		luo_flb_global.incoming.ser = (void *)(header_ser + 1);
> > +		luo_flb_global.incoming.active = true;
> 
> Nit: Not getting FLB data resulted in a error print. I suppose we should
> keep that here as well.

This is no longer necessary. Previously, we relied on the FDT, which 
contained its own errors, but since everything is now passed through 
LUO's own struct, there are no errors to parse through fdtlib. The 
absence of flbs_pa indicates that it was not preserved by the previous 
kernel (i.e., there is no flbs).

> 
> >  	}
> > -
> > -	err = fdt_node_check_compatible(fdt_in, offset,
> > -					LUO_FDT_FLB_COMPATIBLE);
> > -	if (err) {
> > -		pr_err("FLB node is incompatible with '%s' [%d]\n",
> > -		       LUO_FDT_FLB_COMPATIBLE, err);
> > -
> > -		return -EINVAL;
> > -	}
> > -
> > -	header_size = 0;
> > -	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_FLB_HEADER, &header_size);
> > -	if (!ptr || header_size != sizeof(u64)) {
> > -		pr_err("Unable to get FLB header property '%s' [%d]\n",
> > -		       LUO_FDT_FLB_HEADER, header_size);
> > -
> > -		return -EINVAL;
> > -	}
> > -
> > -	header_ser_pa = get_unaligned((u64 *)ptr);
> > -	header_ser = phys_to_virt(header_ser_pa);
> > -
> > -	luo_flb_global.incoming.header_ser = header_ser;
> > -	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
> > -	luo_flb_global.incoming.active = true;
> > -
> > -	return 0;
> >  }
> >  
> >  /**
> 
> > -int __init luo_session_setup_incoming(void *fdt_in)
> > +int __init luo_session_setup_incoming(u64 sessions_pa)
> >  {
> >  	struct luo_session_header_ser *header_ser;
> > -	int err, header_size, offset;
> > -	u64 header_ser_pa;
> > -	const void *ptr;
> > -
> > -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_SESSION_NODE_NAME);
> > -	if (offset < 0) {
> > -		pr_err("Unable to get session node: [%s]\n",
> > -		       LUO_FDT_SESSION_NODE_NAME);
> > -		return -EINVAL;
> > -	}
> >  
> > -	err = fdt_node_check_compatible(fdt_in, offset,
> > -					LUO_FDT_SESSION_COMPATIBLE);
> > -	if (err) {
> > -		pr_err("Session node incompatible [%s]\n",
> > -		       LUO_FDT_SESSION_COMPATIBLE);
> > -		return -EINVAL;
> > -	}
> > -
> > -	header_size = 0;
> > -	ptr = fdt_getprop(fdt_in, offset, LUO_FDT_SESSION_HEADER, &header_size);
> > -	if (!ptr || header_size != sizeof(u64)) {
> > -		pr_err("Unable to get session header '%s' [%d]\n",
> > -		       LUO_FDT_SESSION_HEADER, header_size);
> > -		return -EINVAL;
> > +	if (sessions_pa) {
> 
> Nit: same thing about the error print here.

ditto.

> 
> > +		header_ser = phys_to_virt(sessions_pa);
> > +		luo_session_global.incoming.header_ser = header_ser;
> > +		luo_session_global.incoming.ser = (void *)(header_ser + 1);
> > +		luo_session_global.incoming.active = true;
> >  	}
> >  
> > -	header_ser_pa = get_unaligned((u64 *)ptr);
> > -	header_ser = phys_to_virt(header_ser_pa);
> > -
> > -	luo_session_global.incoming.header_ser = header_ser;
> > -	luo_session_global.incoming.ser = (void *)(header_ser + 1);
> > -	luo_session_global.incoming.active = true;
> > -
> >  	return 0;
> >  }
> 
> -- 
> Regards,
> Pratyush Yadav

