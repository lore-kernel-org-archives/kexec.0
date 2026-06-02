Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D13CD5BD1
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2orsdr+v6yIbfcC4d109Ztib1WHfFanWjEmldcE7TJ4=; b=4wch+yTDowEmh3xxHsvo+9a9GT
	KCLNGfSicGIep5h0/hk56YO489GhB2W5zLncowaPxohqemQZ/E7iMLa9qJ+nDKq+5zYf6Aw+lJRoV
	dxwJ2t4QSOOGkGOSRHgTKGY1b+cKJr6PQNASPwMoFXpg2Os0E/HSDP8LNTgg4szbQ4fYE0o6b0fS4
	g/XS63Kj1T+yAI7NrbnbtLFyZ0/JtDAwtFu5GknwMqsuEx4qOCEEV8dqsonKiNCIkGl9GE78fgaRz
	d1FmykcEguWCooY7cOD9OSJruwhjlOJILsqp9KKPV0EmM31UA9XoItw7A5GqqNMSp2Fiorn6kZO7J
	ksRnGqgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSs4-0000000Da9Y-1zxe;
	Tue, 02 Jun 2026 17:25:44 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSs1-0000000Da91-2Vuu
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:25:43 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c8587427468so1315925a12.1
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780421139; x=1781025939; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2orsdr+v6yIbfcC4d109Ztib1WHfFanWjEmldcE7TJ4=;
        b=kb+FGom2lwjx0NFZMsaYx6Xbn+UnH5ciCcmDKloGSum4PiC0PYcWma7EjePCGAYWpn
         I8oe5yyC/BGOhYUZD24efHHqgJFoPEeeZon5Cv91w3fT+4LgjzZ1+YskmbjeCjNO4r10
         Zre7CU2Kk9Zt9EgMx7EEgBewFeXoYxjVU3rlx250900Sp159XNZtyW9w3SFL78etkWzs
         6ON/CTziG3OPSj9Ie+dBsYtECjXe+5nRiP8kzZJHMw2J6Olo5hMMdvwtcswAK+R6Y4jh
         J0uYlDVuqFJjcM0OshQq8bsExrYthvHtPxR+akOiUU/Nd6WlI/WkRbgaqEV5CbzJCPAZ
         P+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421139; x=1781025939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2orsdr+v6yIbfcC4d109Ztib1WHfFanWjEmldcE7TJ4=;
        b=TkDsxvenfYIWf2f1Jgj/PYgN1lscexxSNyEuoIrb5mt02VDv7oQC+7Qqoi6ubdGqP8
         1yCyWN/Och+ozX5AlHsazwsfobjeY0AkacpVl5Yoot+JSYR7ocBEdO7/M0hX2TYmNcK2
         I1Db5GCYgrdqroYm07cMjitzsg6l8GJT1li18g+HDjfSTlYUhxXgD2CjRg3x7u8Hc3IM
         AZJ7Of94jr7AmtBfvoiM4+GuhEiFMTl4O/IwPGYsCy9duKTMnwU82ipT82QD/dpsb2JL
         L2JSPNFasU293pmIGwBZvFfzTuiIdxAm3BS7/MpHbMTAxqoIYRB6aVHYz8fMz20vZ38Q
         0xDg==
X-Gm-Message-State: AOJu0Yz6l3SD9T8TgcpQppXK5mIpENpPZ3etNeVGfLd4mQWlnxgFKbAP
	KQI6RzObVhSbrh451T+7NioBSOzPMchIFlXgCKWL/153thS9OH5j2QvOThE8ZKVPEA==
X-Gm-Gg: Acq92OGO/wPb4JoZ3w9DG93pmKi65EtLfGKLiVW0Q6CRjz7Utalru4HOpf0nlfcrx5+
	nWFcTH+0QpOK5q+ov3MhodCfeiHYUdj/vjxQxpLp0o6TGHqGRdX1tymULbIUeunx3b322HyVAiD
	7iaVLP5QcqUD12tHkC2ooVOTCt4ZJf7hlmtjADnFsYysY+PvazZE5/xm5anE+qcS8dbXSNyQ2OU
	41Jn6QxFichOnGU8WEDbEFILY/7w0nWjJVL/8qHb1bGMaBc/VbBSRS1thl8G3djQaM+E/BWkyPE
	wyjY/hAVH4u9j65uhsSVWQkdOLJbBDCj6XpKlwkWhalADdgQNGcwiKD83mvWEUESCTo1wrDXytE
	i54DQmN8s/mmemkvLM1MiBl+G7169VZphusLS0z9bM22NTG7Zx12G8luqQ7UBUv7XrPz+o+wEEW
	xda9WPaMwNyWpXtzC3jJ2UP+vY/ajiVmxPEqMBdkgI12xN2HSLDYM0PRJpzzkp77jiVK4TeCIV
X-Received: by 2002:a17:903:390c:b0:2c0:c625:4001 with SMTP id d9443c01a7336-2c0c6254226mr131813415ad.39.1780421138788;
        Tue, 02 Jun 2026 10:25:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01214sm141692365ad.50.2026.06.02.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:25:38 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:25:34 +0000
From: David Matlack <dmatlack@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
Message-ID: <ah8SDsIuZQXyvpZq@google.com>
References: <20260528174140.1921129-1-dmatlack@google.com>
 <20260528174140.1921129-2-dmatlack@google.com>
 <2vxzfr34dfty.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzfr34dfty.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_102541_650516_68AD8A25 
X-CRM114-Status: GOOD (  28.95  )
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

On 2026-06-02 07:15 PM, Pratyush Yadav wrote:
> Hi David,
> 
> On Thu, May 28 2026, David Matlack wrote:
> 
> > Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
> > that the FLB structure cannot be freed while the caller is actively
> > using it. Add an additional liveupdate_flb_put_outgoing() function so
> > the caller can explicitly indicate when it is done using the outgoing
> > FLB.
> >
> > During a Live Update, the kernel may need to fetch the outgoing FLB
> > outside of the scope of a file handler's preserve() and unpreserve()
> > callbacks. In that situation there is no way for the caller to protect
> > itself against the outgoing FLB from being freed while it is using it.
> > Incrementing the reference count in liveupdate_flb_get_outgoing()
> > ensures it cannot be freed.
> 
> We grab a reference to the FLB's module when the first file using the
> FLB is preserved. So the FLB should never go away while preserved files
> exist. Once all preserved files go away, you normally shouldn't be doing
> anything with the FLB anyway.
> 
> Can you please elaborate on the use case and why this is a problem?
> Using the FLB outside of the standard LUO file callbacks sounds
> problematic.

The scenario I had in mind was to remove a PCI device from the outgoing
FLB if the device is forcibly removed while the file is still preserved,
for example someone writes 1 to /sys/bus/pci/devices/.../remove or a
device is physically hot-unplugged.

Specifically this call here from the patch below:

+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
+	 * since there should no longer be any references to @dev on the system.
+	 */
+	if (READ_ONCE(dev->liveupdate.outgoing)) {
+		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+		pci_liveupdate_unpreserve(dev);
+	}
+}

https://lore.kernel.org/linux-pci/20260522202410.3104264-3-dmatlack@google.com/

I can do this without adding reference counting to
liveupdate_flb_get_outgoing(), but the reference counting makes it
obvious that the outgoing FLB will not be freed while I am using it
here, and also aligns with liveupdate_flb_get_incoming().

> >
> > This change also aligns the outgoing FLB lifecycle management with the
> > incoming FLB, since the latter uses the same get/put semantics.
> >
> > Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> > Assisted-by: Gemini:gemini-3-pro-preview
> > Signed-off-by: David Matlack <dmatlack@google.com>
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

