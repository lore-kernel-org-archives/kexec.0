Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8202FCC6B38
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 00:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=btrJprSS194OAW2n6AQnMcqpIUNr9AAzjlrzl1y+2yA=; b=YCGXyT4AaMIsxSDPh37wIsbTre
	6YNb/7Iq20097E80L0B8eY85iQrdbG4E5bgUvXc/3s+cJS70iodHAIDP7A1OSNPO/qb7AtCCv2yj5
	TKDZn93O2/GfLoDy0kuBzDvonJQTF0s82vm9Y0+6+PdsC2Bq3hkB0G6emkq+Wjbih/hgyZ3JgilVn
	kd4iaOIegKMfjdfYPJVyrJTGLQl4/PLL2Nb+/AqV1+luABxBeA9Zt7dJgqpfxJaAScPhl7NmIu0N+
	LJSmcQs7hwFTisHAKASXam8YuMTcBtldlWrvP6ycodCoRCLaifhU3Erl+kWiSBDsBxqu+g9ZNBmoU
	ODoJrETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHVkE-00000001cCT-0iyu;
	Fri, 16 Oct 2026 00:24:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHVkD-00000001cC9-0uG2
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 00:24:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=btrJprSS194OAW2n6AQnMcqpIUNr9AAzjlrzl1y+2yA=; b=adKneUpPJZ1OjxCrkfXLA8b0LB
	n86P3s2fhpGPI/IYWE69fnEZ90AKScLrObRazqKdX9FoaroLS2/+1EnDCtZ/bixR07agYVQVcq+6I
	N7Gn4wQz7GjzoaqvMzqGqxDGMlNKFSl/6TfpnUHrohVNAK2qOaOl0APhgcfqFiQhGhvmKWVax8A9p
	dO2leFeTeAg8+g+elhwM0LrVEY6BvTc6qWqm9XhLF7frqiA2282EPFTCJ70OXPm7rI6/ZXpqbPawp
	1eKtAcKHLVxJ6Pawek+am1hj9wpfdQjUetS41fSG49BzrcbH25y0WhtJAzQnsnaeOEnzd04aOtKhZ
	H0u1ciVg==;
Received: from m16.mail.163.com ([117.135.210.4])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHVk3-00000000weh-0yyK
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 00:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bt
	rJprSS194OAW2n6AQnMcqpIUNr9AAzjlrzl1y+2yA=; b=l+4BKTQpNdNlwWQFiu
	BuDVrswfIwfI88pIRVs3W1EgLbZ29agEgU1aGXwpz1Jnxri+Rgj33aJV00sTvJT7
	5C+VfLImKOUxS2JWQpvQPpNb0BoIYZ80y37Klj2qFKNnDP2KeqPJosEy35nFE7kX
	iJF16pDDYx4fB0hLAZS0POZns=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3H1+KbtFqgGZ0AQ--.60229S2;
	Fri, 16 Oct 2026 08:23:40 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] mm/memfd_luo: MFD_NOEXEC_SEAL memfd becomes executable after restore
Date: Fri, 16 Oct 2026 08:19:00 +0800
Message-ID: <20261016001900.4722-1-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3H1+KbtFqgGZ0AQ--.60229S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF45Wr15Cr1UWF4xXr15CFg_yoWrXrWkp3
	y5Gas8ur1DJrykKw4I9F10qFyfKa1fJr4jvrWSgFyxAan8Wrn2yF4F9FyUWF9xArsrWa1j
	qw4Ykry8A3W7JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5wIDUUUUU=
X-Originating-IP: [2001:250:5828:4461:5d0:1f3:be4d:bdab]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC9g3NlWrRbo1-AgAA3G
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_012412_459991_7A40AF9C 
X-CRM114-Status: GOOD (  12.81  )
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

Hi,

I observed: LUO preserves and restores the seals of a memfd, including
F_SEAL_EXEC, but it does not preserve the inode execute mask protected
by that seal. For a new memfd created with MFD_NOEXEC_SEAL, when it has
not been fchmod'ed, its state before preservation is normally
inode->i_mode & 0777 == 0666, seals = 0x20; however, the new inode
created when LUO restores the memfd has default permission bits 0777,
and the seals also change to 0x3e during restoration.

Although the LUO documentation states that it is not a completely
transparent restoration and that only the listed properties are
guaranteed to be preserved, I think that preserving only F_SEAL_EXEC
without preserving the inode mode, or rather the execute mask, is
somewhat unreasonable. I am not sure whether this matches your intended
design.

To put it somewhat imprecisely, I think the LUO mechanism may bypass
the "no executable memfd may be created" expectation that
vm.memfd_noexec=2 is intended to provide.

The analysis is as follows:

1. If we pass the MFD_NOEXEC_SEAL flag, SYSCALL_DEFINE2 goes through
   the sanitize_flags() check, which may modify flags, and then enters
   memfd_alloc_file().

2. In memfd_alloc_file(), it enters shmem_file_setup() and then
   __shmem_file_setup():

```
	if (flags & MFD_HUGETLB) {
		file = hugetlb_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT),
					HUGETLB_ANONHUGE_INODE,
					(flags >> MFD_HUGE_SHIFT) &
					MFD_HUGE_MASK);
	} else {
		file = shmem_file_setup(name, 0, mk_vma_flags(VMA_NORESERVE_BIT));
	}
```

3. In __shmem_file_setup(), the inode->i_mode obtained by default is
   0777:

```
	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
				S_IFREG | S_IRWXUGO, 0, flags);
```

4. Back in memfd_alloc_file(), inode->i_mode becomes 0666, and
   F_SEAL_EXEC is set:

```
	if (flags & MFD_NOEXEC_SEAL) {
		inode->i_mode &= ~0111;
		file_seals = memfd_file_seals_ptr(file);
		if (file_seals) {
			*file_seals &= ~F_SEAL_SEAL;
			*file_seals |= F_SEAL_EXEC;
		}
	} else if (flags & MFD_ALLOW_SEALING) {
		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
		file_seals = memfd_file_seals_ptr(file);
		if (file_seals)
			*file_seals &= ~F_SEAL_SEAL;
	}
```

5. In memfd_luo_preserve(), LUO obtains the seals of the original
   memfd through memfd_get_seals() and stores them in ser->seals:

```
	seals = memfd_get_seals(args->file);
	...
	ser->seals = seals;
```

6. After switching kernels and restoring the memfd, in the
   memfd_luo_retrieve() function, memfd_luo_retrieve() directly calls
   memfd_alloc_file("", MFD_ALLOW_SEALING). This call creates a new
   shmem inode with permission bits 0777. Since MFD_NOEXEC_SEAL is not
   passed and only MFD_ALLOW_SEALING is, the execute bits are not
   cleared, and the inode mode still remains 0777:

```
	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
```

7. Then, in the memfd_luo_retrieve() function, it enters memfd_add_seals():

```
	err = memfd_add_seals(file, ser->seals);
```

8. In memfd_add_seals(), ser->seals holds the F_SEAL_EXEC that the
   original memfd has because of MFD_NOEXEC_SEAL. Since the restored
   inode is 0777, inode->i_mode & 0111 is true, and
   SHRINK|GROW|WRITE|FUTURE_WRITE are additionally added -> seals
   becomes 0x3e:

```
	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
```

Meanwhile, I noticed the earlier review discussion about the original
seal-preservation patch:

https://lkml.org/lkml/2026/1/26/843
https://lkml.org/lkml/2026/1/26/1044

I feel that your discussion touched on this issue.

I think Pratyush has already come close to the essence of the problem:
"But I think that should be done by preserving the mode of the inode
directly, and then copying the seals back." Unfortunately, that
requirement did not make it into the final implementation.

Regards,
Haolong Wang


