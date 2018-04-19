Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f9AzS-00064Q-7H
 for kexec@lists.infradead.org; Thu, 19 Apr 2018 14:56:55 +0000
Date: Thu, 19 Apr 2018 20:26:06 +0530
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: Re: [PATCH net-next v4 1/3] vmcore: add API to collect hardware dump
 in second kernel
Message-ID: <20180419145605.GA30325@chelsio.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <e69b49f1406d2dcd9cd68e4300939e96cd745559.1523950324.git.rahul.lakkireddy@chelsio.com>
 <20180419082456.GA8617@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419082456.GA8617@kroah.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Indranil Choudhury <indranil@chelsio.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nirranjan Kirubaharan <nirranjan@chelsio.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, Ganesh GR <ganeshgr@chelsio.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "ebiederm@xmission.com" <ebiederm@xmission.com>

On Thursday, April 04/19/18, 2018 at 13:54:56 +0530, Greg KH wrote:
> On Tue, Apr 17, 2018 at 01:14:17PM +0530, Rahul Lakkireddy wrote:
> > +config PROC_VMCORE_DEVICE_DUMP
> > +	bool "Device Hardware/Firmware Log Collection"
> > +	depends on PROC_VMCORE
> > +	default y
> 
> Only things that require the machine to keep working should be 'default
> y', please remove this, it's an option.
> 

Ok. Will fix this.

> > +	help
> > +	  Device drivers can collect the device specific snapshot of
> > +	  their hardware or firmware before they are initialized in
> > +	  crash recovery kernel. If you say Y here, the device dumps
> > +	  will be added as ELF notes to /proc/vmcore
> 
> Which exact "device drivers" are you referring to here?
> 

The API is generic enough to collect any type of device's dump. Any
driver that wants to collect its underlying hardware/firmware dump
can use the API. In our case, cxgb4 driver collects dumps of the
underlying Chelsio network devices.

Thanks,
Rahul

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
