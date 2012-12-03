Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TfP75-0007uY-Mn
 for kexec@lists.infradead.org; Mon, 03 Dec 2012 06:02:44 +0000
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Sun, 2 Dec 2012 23:02:37 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B4A463E4003F
 for <kexec@lists.infradead.org>; Sun,  2 Dec 2012 23:02:31 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB362Xa7168974
 for <kexec@lists.infradead.org>; Sun, 2 Dec 2012 23:02:33 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB362WTL024374
 for <kexec@lists.infradead.org>; Sun, 2 Dec 2012 23:02:33 -0700
Message-ID: <50BC4073.7060402@linux.vnet.ibm.com>
Date: Mon, 03 Dec 2012 11:32:27 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
References: <50A4E524.8020702@linux.vnet.ibm.com>
 <348117236.32179739.1352989665917.JavaMail.root@redhat.com>
 <20121115155557.GF2529@redhat.com> <50A60CF2.6010309@linux.vnet.ibm.com>
 <20121116143649.GA4515@redhat.com>
 <20121120184755.01bc3c780dc226fe32f06e66@mxc.nes.nec.co.jp>
 <50AC809E.9060907@linux.vnet.ibm.com> <20121121135721.GB13114@redhat.com>
 <50AE5D89.2090101@linux.vnet.ibm.com> <20121126140448.GA28057@redhat.com>
In-Reply-To: <20121126140448.GA28057@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, buendgen@de.ibm.com



On 2012-11-26 19:34, Vivek Goyal wrote:

> On Thu, Nov 22, 2012 at 10:44:49PM +0530, Aravinda Prasad wrote:
> 
> [..]
>> Customers who want to filter their dump would certainly prefer a single
>> tool and a single shot to throw away pages, scrub data and then
>> compress, split or send the resulting dump to some target using ssh.
>> This important functionality is lost if scrubbing is not part of
>> makedumpfile and a separate tool is developed which just does scrubbing.
> 
> Customers do filtering from initramfs context. It is not practical to
> save TB of memory and filter it later. And we just concluded that is
> it not practical to do scrubbing from initramfs due to need of vmlinux.
> 
> So doing filtering and doing scrubbing will not happen at the same
> time practically. So bloating size of makedumpfile does not make
> sense to me.
> 


Another approach is to dynamically load libeppic library - similar way
how crash does it. No major changes will be done to makedumpfile code,
except the addition of --eppic flag. Upon specifying --eppic flag
makedumpfile will dlopen libeppic.so, which will have functionality to
scrub the specified data. This will prevent makedumpfile bloat and will
not affect the size of initramfs as --eppic is only specified during
post processing. The distribution should build and ship libeppic.so and
the procedure for building .so will be similar to what we have in crash.

> Thanks
> Vivek
> 


-- 
Regards,
Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
