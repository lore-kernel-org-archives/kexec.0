Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzGjK-00035x-GU
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 00:03:48 +0000
Date: Mon, 20 Feb 2012 10:47:51 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH v7 00/10] fadump: Firmware-assisted dump support for
 Powerpc.
Message-ID: <20120219234751.GA10186@bloggs.ozlabs.ibm.com>
References: <20120216111050.4733.38034.stgit@mars>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120216111050.4733.38034.stgit@mars>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kexec-ml <kexec@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Ananth Narayan <ananth@in.ibm.com>

On Thu, Feb 16, 2012 at 04:44:06PM +0530, Mahesh J Salgaonkar wrote:

> Please find the version 7 of the patchset that implements firmware-assisted
> dump mechanism to capture kernel crash dump for Powerpc architecture.
> Firmware-assisted dump is a robust mechanism to get reliable kernel crash
> dump with the assistance of firmware. This approach does not use kexec,
> instead firmware assists in booting the kdump kernel while preserving memory
> contents.

For the series:

Reviewed-by: Paul Mackerras <paulus@samba.org>

I think it's pretty much good enough to go in now.  I have one relatively
minor comment about a printk which could be addressed if you decide to
do another version of the series.

Paul.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
