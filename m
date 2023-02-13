Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C45BC636D4
	for <kexec@archiver.kernel.org>; Mon, 13 Feb 2023 12:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l2m52/FYjEUAOwOlm/28TeQr2IWPF53aXz66NPA/fzE=; b=DJXCjR0I1aohAf
	LS5eimDqGcY63SrvDean+EHwRjOFeX76vBYaI4xpjdIhCVjs8ocDdNaKEoRAg0J5D7biJGlHoznAn
	Dg9sJp1zvRvkymJU1YrRmUfelkIxS87r7ab+pkwPAJ1mgTh8T2eC2UJDQ5GWvmob73y5Ce+gr3yhS
	qo8agh64NUpYoIWJKEFLH1OzDPmL+ORMRi7aXDRsBazM5mndvdVJhzSb86NPGEvu/TE+TDuKpSQBw
	PLkA7VD3B94aZR+/a6Hl5z7n1t8hgZePMvKGfHMejOKGSl4cIabpnMc1sOYHTpHDADVti40ZjS8+k
	P8dYLGNOOkwvRKHDTxFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRYKO-00EiWo-KZ; Mon, 13 Feb 2023 12:53:04 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRYKL-00EiTO-9s
	for kexec@lists.infradead.org; Mon, 13 Feb 2023 12:53:02 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1676292771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kt2OK2YUgy+eskKKqGKLmdkLvjzs+zgQaWcCfhotpwU=;
	b=zNus41ARORGE+j8gBIE7+HCsLeoYY24/UX8ZgfuousAFn2ZfI00dzrRknT+bPn/9BHgx40
	0L6yleX8ptxdrzJUDisilt93HRA/MHZJ1M8DEt3VT/SbASd7yhdvhy/6vvPaydCUbRW3Jo
	tUMe4hEM9nzqDh+NvSrEk64TUT2y75VhsNJoTb8ITlxylKLTpGT8r5c75st12amJRRyygR
	q8b5IJ5M+LLx9I8uUqnT6LA5nOGzDNSMaerXbvrmVmUvFGWJdzogrnq9TLkbp0nMIrZBx0
	6WpvYPXcMpBqipnyCNonv8yAE73HpT5hTESf/Kl9ef/LrF5C1LAiwdAap9z+zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1676292771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kt2OK2YUgy+eskKKqGKLmdkLvjzs+zgQaWcCfhotpwU=;
	b=SX8v1GdsioisJ0hWeYrj3TpgQwWdojaqpeRg8G+z0RejSrdLoDQjdPGC4yrqQCl7YwPp25
	6iD0WeSTmPOcV0CA==
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Eric DeVolder
 <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
 bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
Date: Mon, 13 Feb 2023 13:52:50 +0100
Message-ID: <87ttzpzpzx.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_045301_511177_D0DAFDDD 
X-CRM114-Status: UNSURE (   4.71  )
X-CRM114-Notice: Please train this message.
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

On Mon, Feb 13 2023 at 10:10, Sourabh Jain wrote:
> The sysconf document says _SC_NPROCESSORS_CONF is processors configured, 
> isn't that equivalent to possible CPUs?

glibc tries to evaluate that in the following order:

  1) /sys/devices/system/cpu/cpu*

     That's present CPUs not possible CPUs

  2) /proc/stat

     That's online CPUs

  3) sched_getaffinity()

     That's online CPUs at best. In the worst case it's an affinity mask
     which is set on a process group

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
