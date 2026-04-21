Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB133F94CA7
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/JJh9D4iHfbIL7VgfpIvEFwBxZt49NSTXxWwWS0h9Q=; b=E7TqwsHOwAUJjkJZphxzpITXGu
	xY0WfGWAemD3vFQ4PmAxa5BAEo9vEMvybb7X9WYm7rk4kvRL8lDUeDjt7ZB56MW54HpRS+3kkWN9H
	SyHs+xxw5s47DeKxY7ygLw6xZgjYwhqc+X4Tu1y6WEa4QQLkNMfPYst6+FqQOwoipdwS+WgrGU6CX
	eQPGveJKwF8mJ3yhe9oNxzdA0lPP/dE6/DxmwBx/bSfCkmKcYFKOVBljIsAvLGgW9rsrLyYOgoVAP
	eJ/YUWWEQrVgqz+FRrXxvhaJhKKlWSRPIONp5lQwmM+IaaS3rs+/0V0F9MNNoFm6FwTAXmR8ke2KS
	y3c2xgow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFGNZ-000000094Bu-2SPE;
	Tue, 21 Apr 2026 19:03:25 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFGNW-000000094BQ-2u3T
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 19:03:23 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-38e800deae4so38153411fa.0
        for <kexec@lists.infradead.org>; Tue, 21 Apr 2026 12:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776798200; cv=none;
        d=google.com; s=arc-20240605;
        b=d2Lk6x5w4wKnSmCZUuumtDV1IWlalcwZT5nDabRZiNZGFNp10Siyr069P4gdJjFfxj
         a4NULztOx0F7tcVgHnZVRKJCzXBJoVrHAZRT5ovNZZtRUHqNxaf3eGFS5qBHAyZPsfqE
         EIzNAv+wqd3NsvZ9hNB7siOeEhWUkcycBvA9tQ1LHAti3ZP1gPjsgadNn+poR33T6cUd
         cw5F9OyYHzJaz2b0FKuX8yBYmvv4ucwOMz+xhMezpzgk5abV/Gjn+tz/5vEuvRSEf0Fb
         GdiibWvI+DNproa8OzuZcRkrUnnhCP+QQjtX7/xYJZeFjIwqcPtn8WlfKM1vjKBnlIHt
         FTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j/JJh9D4iHfbIL7VgfpIvEFwBxZt49NSTXxWwWS0h9Q=;
        fh=kFbu6qMVrEBNqbBf/hmwZbpsJ/eIEB6MrgzinAGxa3Q=;
        b=DtJ1y1gClQT6nQyW0zg8VeVHEAfqWM/+KZaTunVK6VMAUB8z/hd9vA8TpvDh4f14sR
         RdQCa/4ty/p71C0+uIWF/s5NAOsskllvS7IDMOY8SreHrIPzb3hRhqwm5IClwD+GL0bU
         TvFWD2C5e6Mgzj4xpuA0+mKcSesR10Kyl0aN0F4EgPgSLTkeRRIssr3LEktlEOsQGOhx
         P8Jvwb0Sy3aOZs+c4Jsqxmz39K70uOL8jVhEi9trPC5y+r4HBi4WDMhvgpPvbZMyp4NL
         AfhTpd0A8VpLnZ0hxdjyiMu2bA76G1GJNUpQqT+O4SfBS27HlOXRXbJHrdx88jFa31Yb
         tphQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776798200; x=1777403000; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/JJh9D4iHfbIL7VgfpIvEFwBxZt49NSTXxWwWS0h9Q=;
        b=ATFz16LDyw2NfmzB+3xJy9eFcb7uqvRT3wMRmRa3oZI12Lb3+DF+o/tzsk8eOS4mD0
         rvD+NjlpcPlqhOPTog5xA/cyVEXvSZmqjbr8H0NzH1hXHAGEFuYfBuOpqcSZ0QSlnBUD
         Q4pu+lswoiUx0KyckU/Rap9eG4wbqolE0RzgunMgSL7Jgt4wSfsbmLtnbn6hRYs/sA69
         FpLE78EjBrLfrFraKCSQJ5t+/JDjkC1Mi7Hs4Jyut6TtEnQHr5caA3IhKkKo74jtCJ5g
         BJqxPSsp2WV84UN6r6BCvAwBcBJOFSZZLrud39ZmblOc83ec8GDnT0htmHrrHEOWqcGo
         mXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798200; x=1777403000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/JJh9D4iHfbIL7VgfpIvEFwBxZt49NSTXxWwWS0h9Q=;
        b=VlJf5jjGjG8xbWyTlBSk25keFWiftlZoZ18ppVLRGze8VzGdFcEzyzxG0/HE1R3rgg
         lVFRuf/xQZKlSfu4Yd4r4GcXBopjpgBRr0yg7hxuawILIV7jEF4oS8N1pI/1JJVufAtK
         5ueVMf2ie+BJRHiFgEg4xgmLgBXLUEDQDAemIUagE/aQcNK2zE64vhQbMoXDbkLMuw6M
         DX6859f7wn8C29BBQLci8mRkm1rSUEuoynZkLLl7L/0st0ziTlSQ2PlO4rp7f021g6tc
         Kjv4nBRHPOuAbrry4flTE4bdGg/Wq5nAbVIo3NTsziNEHg59zXRtnEaw66tq1kEozDTn
         vEjw==
X-Forwarded-Encrypted: i=1; AFNElJ9vHv+ORfbXSqRQd9Y9tygUNXXkqBA6qF5NwMCr86votpiU8MzBOm5oHwGSv/g/Tti4mOQNcg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzictq5bCS2Rnu6lacwQNnyBsqR+6hPE3ldhMb3SqOkNmcyptxC
	Ol2F4AGzfonAmt/VSUapUjI/vrXvb5s1nnDdQLvZ8V9y2E1jkRdVci9Cv8jRDxkjSBZmm29PeZ4
	bsE8AOMAbdVDKxHlA706X0J3CFL32OiRYxdoucfiY
X-Gm-Gg: AeBDievBbPhZn/BqBAsIZCfFLuaZ2Pjy1OHK21cJ1981dbwBxNFmAK4KmXOQG83ox1G
	XAJ/xtf5YQ0fMbcaFhhcBsiBE7CoVn6gCqdv28AQV0Cxy+oTjlrbmUuro8QMCRWTW14mLioTZaf
	zFIGFk5mJylFQfL8AFazRkOxt79JQOlaYbDAUgT7EiBLXp4RFD4DuDF6bL5rjUl4HpK0m1bAxrr
	yiXnXx/OvA0H+JKuzRzb5evNMB2DkT4MVArm1GKiYmMJVLRli2YQJpd28S9llfjimcozvEMSnif
	0fj10FXdKZAy2ERmkvrlWkKxPx1gCQ==
X-Received: by 2002:a2e:a913:0:b0:38e:21bb:b2ad with SMTP id
 38308e7fff4ca-38ec77fb34amr60020221fa.2.1776798199609; Tue, 21 Apr 2026
 12:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
 <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com> <20260421184433.GG3199414@nvidia.com>
In-Reply-To: <20260421184433.GG3199414@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Apr 2026 12:02:51 -0700
X-Gm-Features: AQROBzApHbC_QwlDNMpyz8z8DrBINgdkBviaRKsddB8iPIY8E4-Zx9sb-aAKTZM
Message-ID: <CALzav=cFarR4q7NugCxXwCW6wnyU9dJRaaTnxs7MY5ia5SDJWQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_120322_786962_648CD903 
X-CRM114-Status: GOOD (  27.22  )
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

On Tue, Apr 21, 2026 at 11:44=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Tue, Apr 21, 2026 at 10:40:29AM -0700, David Matlack wrote:
> > On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> >
> > > +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args=
 *args)
> > > +{
> > > +       struct vfio_device *device =3D vfio_device_from_file(args->fi=
le);
> > > +       struct vfio_pci_core_device *vdev;
> > > +       struct pci_dev *pdev;
> > > +       int ret;
> > > +
> > > +       vdev =3D container_of(device, struct vfio_pci_core_device, vd=
ev);
> > > +       pdev =3D vdev->pdev;
> > > +
> > > +       guard(mutex)(&device->dev_set->lock);
> > > +
> > > +       /*
> > > +        * Userspace must disable interrupts on the device prior to f=
reeze so
> > > +        * that the device does not send any interrupts until new int=
errupt
> > > +        * handlers have been established by the next kernel.
> > > +        */
> > > +       if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {
> > > +               pci_err(pdev, "Freeze failed! Interrupts are still en=
abled.\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       vfio_pci_core_try_reset(vdev);
> >
> > I think a call to pci_clear_master() is needed here to so the device
> > stops issuing memory transactions while VFIO is trying to resetting
> > it.
>
> That doesn't sound right, reset should always work..

pcie_flr() calls pci_wait_for_pending_transaction() which times out
and prints an error message. The reset seems to be working fine though
after that.

>
> Didn't look beyond this hunk but why is a function called 'freeze'
> donig a reset anyhow?

Disabling bus mastering, resetting the device, and restoring
vdev->pci_saved_state in freeze() is temporary. This allows us to pass
the preserved device to the next kernel in a safe idle state. The plan
is to remove them once enough Live Update functionality in VFIO, the
PCI core, and iommufd are working.

> > Sashiko also wondered if pci_clear_master() is needed to ensure that
> > the device has bus mastering disabled during the kexec
>
> Only devices that are not being preserved..
>
> > think that is actually an issue. vfio_pci_core_enable() makes sure
> > that vdev->pci_saved_state has bus mastering disabled, so
> > pci_restore_state() below here should guaranteed it is clear during
> > kexec.
>
> .. and bus mastering should not be disabled on any device expecting to
> be preserved ..

