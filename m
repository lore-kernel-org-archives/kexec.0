Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858B7C07E8A
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2w/xnaRzzKNXDx9xJD1dmK/sd28SIIersnY4GJUzucA=; b=DYxP02yyrROOXt
	X5MIjfTOhYof4TLBB6p/GkGb4DE5EArQnjvQgmto45JXQ+mVAwgj4G39HP9/25gNhPPy1gB2f8ZTl
	EfFHb2mvFFZVgDk5sBuc61zsxIeIYCQAZzDDD94LWgqWKUfrpUU7m5TPS7pAuUELLEhve7l1xDqqw
	b4hC3lIrFFVMPS4YAT2vl4A2j2F5EE5yMZfiAuNIMnoXNVgD5mmWyO3ZgrRcKUXd/OSi8A31sMDqq
	mjgWqi54agzyY3mpYC6iqoXwosIxwgUqbe6Im0xazcosEg2Jp0oVkPj8iRrirXlo8VPiDDmFFhuQc
	WbvpBLRppe/eESx1O5Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxz-0030mY-0p;
	Tue, 01 Aug 2023 18:19:31 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtxw-0030ka-1B
	for kexec@lists.infradead.org;
	Tue, 01 Aug 2023 18:19:29 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 25642238AE99;
	Tue,  1 Aug 2023 11:19:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25642238AE99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690913966;
	bh=b4OdcS9sda7T2b0PHVgizsmccOm9TXwQxgnEJfHhAx0=;
	h=From:To:Cc:Subject:Date:From;
	b=eS8FMRFIyDnqlgfFkDfZxDa/G5VqNOJ6/fDUQwPB0pU/HNFouLWc1OUHO9MraPEvv
	 UTleLgGK+Qy6d/+7fXseSeLfG2uECVRl8l11t3dZF+A+q0OCb65ziVTTb5UES0gwpr
	 rjgCE5Ye22xF3DeTjmFHQU1NdUuysEYAsL4O6jDU=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	ebiederm@xmission.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH 0/6] Measuring TPM update counter in IMA
Date: Tue,  1 Aug 2023 11:19:11 -0700
Message-Id: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_111928_448277_682F50BE 
X-CRM114-Status: GOOD (  11.39  )
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

Entries in IMA log may be lost due to code bugs, certain error conditions
being met etc.  This can result in TPM PCRs getting out of sync with the
IMA log.  One such example is events between kexec 'load' and kexec
'execute' getting lost from the IMA log when the system soft-boots into
the new Kernel using kexec[1].  The remote attestation service does not
have any information if the PCR mismatch with IMA log is because of loss
of entries in the IMA log or something else.  TPM 2.0 provides an update
counter which is incremented each time a PCR is updated [2]. Measuring the
TPM PCR update counter in IMA subsystem will help the remote attestation
service to validate if there are any missing entries in the IMA log, when
the system goes through certain important state changes (e.g. kexec soft
boot, IMA log snapshotting etc.)

This patch series provides the required functionality to measure the
update counter through IMA subsystem by -
 - introducing a function to retrieve PCR update counter in the TPM
   subsystem.
 - IMA functionality to acquire the update counter from the TPM subsystem.
 - Measuring the update counter at system boot and at kexec Kernel
   load.


This patch series would be a prerequisite for the next version of kexec
load/execute series[1] and the future IMA log snapshotting patch series.

[1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
    ima: measure events between kexec load and execute

[2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
    Section 22.4.2, Page 206.

Tushar Sugandhi (6):
  tpm: implement TPM2 function to get update counter
  tpm: provide functionality to get update counter
  ima: get TPM update counter
  ima: implement functionality to measure TPM update counter
  ima: measure TPM update counter at ima_init
  kexec: measure TPM update counter in ima log at kexec load

 drivers/char/tpm/tpm-interface.c   | 28 +++++++++++++++++
 drivers/char/tpm/tpm.h             |  3 ++
 drivers/char/tpm/tpm2-cmd.c        | 48 ++++++++++++++++++++++++++++++
 include/linux/ima.h                |  1 +
 include/linux/tpm.h                |  8 +++++
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_init.c  |  3 ++
 security/integrity/ima/ima_main.c  | 29 ++++++++++++++++++
 security/integrity/ima/ima_queue.c | 16 ++++++++++
 10 files changed, 141 insertions(+)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
