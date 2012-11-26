Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TczIy-0000Wj-Cd
 for kexec@lists.infradead.org; Mon, 26 Nov 2012 14:05:01 +0000
Date: Mon, 26 Nov 2012 09:04:48 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121126140448.GA28057@redhat.com>
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com>
 <50A60CF2.6010309@linux.vnet.ibm.com>
 <20121116143649.GA4515@redhat.com>
 <20121120184755.01bc3c780dc226fe32f06e66@mxc.nes.nec.co.jp>
 <50AC809E.9060907@linux.vnet.ibm.com>
 <20121121135721.GB13114@redhat.com>
 <50AE5D89.2090101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50AE5D89.2090101@linux.vnet.ibm.com>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, anderson@redhat.com, buendgen@de.ibm.com

On Thu, Nov 22, 2012 at 10:44:49PM +0530, Aravinda Prasad wrote:

[..]
> Customers who want to filter their dump would certainly prefer a single
> tool and a single shot to throw away pages, scrub data and then
> compress, split or send the resulting dump to some target using ssh.
> This important functionality is lost if scrubbing is not part of
> makedumpfile and a separate tool is developed which just does scrubbing.

Customers do filtering from initramfs context. It is not practical to
save TB of memory and filter it later. And we just concluded that is
it not practical to do scrubbing from initramfs due to need of vmlinux.

So doing filtering and doing scrubbing will not happen at the same
time practically. So bloating size of makedumpfile does not make
sense to me.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
