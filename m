Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BEDC47074
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 20:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/mea3nP3B+vV8qjWult9mTL/IKxmg6dAa6M9fQt1WU=; b=YNB7qPAq5ZDxxO
	0BPAoYEellAQHKUrNJAcwts2yeEDa1VGnuRpxFaRy2EoLrusHx2skgoDHCtqqK/nzABku8hmB7cgV
	TN5jP6bBd4TxsE6I12zrXp5Q3FV/TqDIkPxFGUQhgkg0Q3Wwck+vgtKnNkpHta/ZqrTEsQ6Dn/+y7
	uZa3pKTaWUeEDk5E0uC+mtg4nMlF0Kr3kbl9xIseHtI0FlwGft4cHF1xuTi8ZC0ltWV0MsHA9gv5t
	595zI8afUlToxBc/qbNfQzX7Z6C4F8B+0Gl+ya/RDOZF0nPPMG0zrpIbMcuBGpgS4En73LjDXEQ5q
	h0yK7W48WkZY4itHb7NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlDw-008ul8-0w;
	Tue, 02 Jan 2024 20:18:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKlDt-008uk9-1k;
	Tue, 02 Jan 2024 20:18:50 +0000
Received: from skinsburskii. (c-73-239-240-195.hsd1.wa.comcast.net [73.239.240.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8634120B3CC1;
	Tue,  2 Jan 2024 12:18:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8634120B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704226728;
	bh=JFUj3C7F4v1llVh0SHjV/UZr4Y8Q5mWVzW88656cZ4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBZq+QImwExtqzfSMUaFBx5SqLCBQZlhbdMiNYB9OQZDuVtBKnZllTeupWgAKu58t
	 4yOsU39+h82ZiQ2rxDh7b264mytw7f1GFBNGYW+/MioPPM90R/n2xElpJXMoDcvHCU
	 nesWzuBT96S1hmpCoXyzFXlJiuFt3xFbHxdqt+iM=
Date: Sun, 31 Dec 2023 19:55:18 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
Message-ID: <20240101035518.GA804@skinsburskii.>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-8-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222193607.15474-8-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_121849_671908_7E7B1D0F 
X-CRM114-Status: GOOD (  20.74  )
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

On Fri, Dec 22, 2023 at 07:35:57PM +0000, Alexander Graf wrote:
> diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concepts.rst
> new file mode 100644
> index 000000000000..8e4fe8c57865
> --- /dev/null
> +++ b/Documentation/kho/concepts.rst
> @@ -0,0 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=======================
> +Kexec Handover Concepts
> +=======================
> +
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
> +arbitrary properties as well as memory locations - across kexec.
> +
> +It introduces multiple concepts:
> +
> +KHO Device Tree
> +---------------
> +
> +Every KHO kexec carries a KHO specific flattened device tree blob that
> +describes the state of the system. Device drivers can register to KHO to
> +serialize their state before kexec. After KHO, device drivers can read
> +the device tree and extract previous state.
> +
> +KHO only uses the fdt container format and libfdt library, but does not
> +adhere to the same property semantics that normal device trees do: Properties
> +are passed in native endianness and standardized properties like ``regs`` and
> +``ranges`` do not exist, hence there are no ``#...-cells`` properties.
> +
> +KHO introduces a new concept to its device tree: ``mem`` properties. A
> +``mem`` property can inside any subnode in the device tree. When present,

Should it be "property can be" ?

...

> diff --git a/Documentation/kho/usage.rst b/Documentation/kho/usage.rst
> new file mode 100644
> index 000000000000..5efa2a58f9c3
> --- /dev/null
> +++ b/Documentation/kho/usage.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +====================
> +Kexec Handover Usage
> +====================
> +
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
> +arbitrary properties as well as memory locations - across kexec.
> +
> +This document expects that you are familiar with the base KHO
> +:ref:`Documentation/kho/concepts.rst <concepts>`. If you have not read
> +them yet, please do so now.
> +
> +Prerequisites
> +-------------
> +
> +KHO is available when the ``CONFIG_KEXEC_KHO`` config option is set to y
> +at compile team. Every KHO producer has its own config option that you

Should it be "at compile time."?
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
