Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZbE-007YdT-Hn
 for kexec@lists.infradead.org; Wed, 14 Apr 2021 07:06:10 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKtjs4SskzB0jN
 for <kexec@lists.infradead.org>; Wed, 14 Apr 2021 15:03:45 +0800 (CST)
From: Jingxian He <hejingxian@huawei.com>
Subject: kexec-starting-kernel-problem-on-vm
Date: Wed, 14 Apr 2021 15:04:26 +0800
Message-ID: <20210414070426.396692-1-hejingxian@huawei.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8777880534663948233=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: hewenliang4@huawei.com, wuxu.wu@huawei.com, horms@verge.net.au, hejingxian@huawei.com

--===============8777880534663948233==
Content-Type: text/plain

We use ���kexec ���l��� and ���kexec ���e��� on our virtual machine to upgrade the
linux kernel. We find that the new kernel may start fail due to checking
the sha256 sum of the initrd segment checking fail with low probability.

The related code is as following:
/* arch/x86/purgatory/purgatory.c */
static int verify_sha256_digest(void)
{
	struct kexec_sha_region *ptr, *end;
	u8 digest[SHA256_DIGEST_SIZE];
	struct sha256_state sctx;

	sha256_init(&sctx);
	end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);

	for (ptr = purgatory_sha_regions; ptr < end; ptr++)
		sha256_update(&sctx, (uint8_t *)(ptr->start), ptr->len);

	sha256_final(&sctx, digest);

	if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)))
		return 1;

	return 0;
}

void purgatory(void)
{
	int ret;

	ret = verify_sha256_digest();
	if (ret) { //<------verify_sha256 fail, entering loop forever
		/* loop forever */
		for (;;)
			;
	}
	copy_backup_region();
}


Our opnion of this problem:
We think that the process of relocating the new kernel depending on the
boot cpu running without interruption. However, the vcpus may be interrupted
by the qemu process with async_page_fault interruption.
There exists memory overriding risk when the boot vcpu relocate the new kernel.

When we enable the KVM_GUEST feature, and make the memory less than 500M,
The new kernel starting problem with ���kexec -l/-e��� will happen at every time.

My last question is:
Are ���kexec ���l��� and ���kexec ���e��� commands not applicable on virtual machines?



--===============8777880534663948233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8777880534663948233==--
