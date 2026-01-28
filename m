Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF004D35663
	for <kexec@archiver.kernel.org>; Wed, 28 Jan 2026 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQf/HBwTqp3sbWkLuE4rQUJP+mP0ujQp7ARzpVJXjTI=; b=RyNUFAGU4ROsMhSrUHfusE1bCo
	sf6U5WINDKuP+ot9a5iRPqhOBGFfy335/nTcOrL0N4hG/Mzh6aSn/m5r3Ywzj1qNELLAKToTbLr46
	TtTmb729UViOuiSp5e35kpt792qzHUwsQfa0kN+f57GgjYpK+s6brH55C3QA4yOGrNgu2burTiR4Y
	vIM3xLx0IZuiitxHQbRthznyPeX7Gd0fAbSa03a5sEK3YR8pfOl7wzMUMXpTIVICfazUHqX1AVIsa
	+84xEO4/YfHclMRZwkZ8RrV+UTkprMu5W01w9+OaLS7lE7BETR963biNa8ZOn4ech/chHVYWnrxDK
	e+cSl8KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkv3C-0000000FISH-2cNC;
	Wed, 28 Jan 2026 02:12:58 +0000
Received: from sender4-pp-g126.zoho.com ([136.143.188.126])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkv39-0000000FIRv-2PsX
	for kexec@lists.infradead.org;
	Wed, 28 Jan 2026 02:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1769566370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gTKcDOy6AWWdlCyJZz+FJFNNOopF5QM2AX4Y0yEOU+O3b3HD3TLh9teopUaEru5uPvLK2bN1zdobOQLY0A0FBgUL1F1cr4FKk3xw4YRIBVtVy7emWfiY003evGGCdfq4c0yHwxKsvOjr0k2JVZk11QyNP+X615baUs5MJ8qTb2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769566370; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eQf/HBwTqp3sbWkLuE4rQUJP+mP0ujQp7ARzpVJXjTI=; 
	b=kleVgLx223w1AhtdsyMoTnsS+e6fUACA2tNMRhKCVIvcDd04E/ywxMySI2NRZ2AZr6xt5UdByXu0EmVK6b3wKsKEke7/+PZLYTTcKkBhHJB42mBS8fG7enbyRv9bj+T0KMUbNPgnpVJUF5NAyFn7SbevNTJNiH3WkiLhiaoqEuk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769566370;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eQf/HBwTqp3sbWkLuE4rQUJP+mP0ujQp7ARzpVJXjTI=;
	b=U7dlk702vgtiEs6B+F897hswklP4kInVmtXxAEzXzV42QguRUfmMbOCnwYl+0G0G
	VMKI7rCLIYnRMSTLiDlSllDGhk4C4aoQoKE/fVymVWntuQntwTFTNq8eOEoDDSGnp6K
	dTnQ9pfqUb0eRfnaqwKLM41ku4wmwpAHqE3nQcng=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 176956636844617.840325763325495; Tue, 27 Jan 2026 18:12:48 -0800 (PST)
Date: Wed, 28 Jan 2026 10:12:48 +0800
From: Li Chen <me@linux.beauty>
To: "Baoquan He" <bhe@redhat.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Steven Chen" <chenste@linux.microsoft.com>,
	"Alexander Graf" <graf@amazon.com>,
	"Sourabh Jain" <sourabhjain@linux.ibm.com>,
	"Philipp Rudo" <prudo@redhat.com>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ricardo Ribalda" <ribalda@chromium.org>,
	"Ross Zwisler" <zwisler@google.com>,
	"kexec" <kexec@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19c025ff2ae.7eb49b99801794.5565209326129667667@linux.beauty>
In-Reply-To: <aXhRqvzeX2tUGvia@MiWiFi-R3L-srv>
References: <20260120124005.148381-1-me@linux.beauty> <aXhRqvzeX2tUGvia@MiWiFi-R3L-srv>
Subject: Re: [PATCH] kexec: derive purgatory entry from symbol
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_181255_662385_4140D0B8 
X-CRM114-Status: GOOD (  23.91  )
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

Hi Baoquan,

 > Hi Li Chen,
 >=20
 > On 01/20/26 at 08:40pm, Li Chen wrote:
 > > kexec_load_purgatory() derives image->start by locating e_entry inside=
 an
 > > SHF_EXECINSTR section. If the purgatory object contains multiple execu=
table
 > > sections with overlapping sh_addr, the entrypoint check can match more=
 than
 > > once and trigger a WARN.
 > >=20
 > > Derive the entry section from the purgatory_start symbol when present =
and
 > > compute image->start from its final placement. Keep the existing e_ent=
ry
 > > fallback for purgatories that do not expose the symbol.
 > >=20
 > > WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0,=
 CPU#10: kexec/1784
 > > Call Trace:
 > >  <TASK>
 > >  bzImage64_load+0x133/0xa00
 > >  __do_sys_kexec_file_load+0x2b3/0x5c0
 > >  do_syscall_64+0x81/0x610
 > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 > >=20
 > > Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sectio=
ns")
 > > Signed-off-by: Li Chen <me@linux.beauty>
 >=20
 > Thanks for fixing the issue. Could you tell how we can trigger this
 > issue so that I can reproduce it?
 >=20
 > > ---
 > >  kernel/kexec_file.c | 24 ++++++++++++++++++++++--
 > >  1 file changed, 22 insertions(+), 2 deletions(-)
 > >=20
 > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
 > > index 3f1d6c4e8ff2..d3c68c6b4bbc 100644
 > > --- a/kernel/kexec_file.c
 > > +++ b/kernel/kexec_file.c
 > > @@ -880,6 +880,8 @@ static int kexec_calculate_store_digests(struct ki=
mage *image)
 > >  }
 > > =20
 > >  #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 > > +static const Elf_Sym * kexec_purgatory_find_symbol(struct purgatory_i=
nfo *pi,
 > > +                  const char *name);
 >=20
 > Here, is it better to move the whole function body of
 > kexec_purgatory_find_symbol() here so that kexec_purgatory_setup_sechdrs=
()
 > can see it too?
 >=20
 > Other than the concerns about how to reproducing and above one, this
 > patch looks good to me.

Thanks for the review.

For reference, I observed this WARN on x86_64 with linux-next tag
next-20260106 and the savedefconfig included below. Toolchain was GCC
15.2.1 and binutils 2.45.1.

The WARN is triggered in the kexec_file_load path (kexec -s -l), during
purgatory load/relocation. No kexec -e is required.

command I used:

  sudo kexec -s -l /boot/vmlinuz-$(uname -r) \
    --initrd=3D/boot/initramfs-$(uname -r).img \
    --append=3D"$(cat /proc/cmdline | sed -E \"s/(^| )BOOT_IMAGE=3D[^ ]+//g=
\")"

Regarding kexec_purgatory_find_symbol(), agreed; I will move the helper
body above kexec_purgatory_setup_sechdrs() in v2 to avoid the forward
declaration.

kernel config:
https://gist.github.com/FirstLoveLife/b0e7c7da7146f1ba63167b76cb10683a

Regards,
Li=E2=80=8B


