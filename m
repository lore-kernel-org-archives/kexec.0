Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y83M2-00070U-2X
 for kexec@lists.infradead.org; Mon, 05 Jan 2015 08:49:38 +0000
Date: Mon, 5 Jan 2015 09:49:11 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] kdump, vmcoreinfo: report actual value of phys_base
Message-ID: <20150105094911.40508832@hananiah.suse.cz>
In-Reply-To: <20150102134240.GD18785@redhat.com>
References: <20141113.113011.630216167285231824.d.hatayama@jp.fujitsu.com>
 <20141215151120.b44112413e15a8c390d39147@linux-foundation.org>
 <20150102134240.GD18785@redhat.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, anderson@redhat.com, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2 Jan 2015 08:42:40 -0500
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Dec 15, 2014 at 03:11:20PM -0800, Andrew Morton wrote:
> > 
> > (cc trimmed a bit)
> > 
> > On Thu, 13 Nov 2014 11:30:11 +0900 (JST) HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > 
> > > Currently, VMCOREINFO note information reports the virtual address of
> > > phys_base that is assigned to symbol phys_base. But this doesn't make
> > > sense because to refer to phys_base, it's necessary to get the value
> > > of phys_base itself we are now about to refer to.
> > 
> > Folks, could we please get a bit of reviewing, acking or nacking for
> > this one?
> 
> To me this patch is more like a hack or a quick fix to get dump filtering
> working when dump is generated using virsh-dump like tools. I feel there
> should be discussion on what's the proper way to do this. I don't have
> very specific ideas though at this point of time.

For one thing, the virtual address of phys_base is useless. This is
nicely demonstrated by the fact that it is not used by any kernel dump
processing project I'm aware of (crash, makedumpfile, libkdumpfile).

On the other hand, either the _value_ of phys_base or its _physical_
location in RAM would be useful. If it was available, I would
immediately start using it in libkdumpfile to determine kernel physical
base. In fact, writing a similar patch was already on my TODO list when
Daisuke sent his.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
