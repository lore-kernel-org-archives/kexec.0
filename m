Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y72VQ-0000Bu-4t
 for kexec@lists.infradead.org; Fri, 02 Jan 2015 13:43:08 +0000
Date: Fri, 2 Jan 2015 08:42:40 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] kdump, vmcoreinfo: report actual value of phys_base
Message-ID: <20150102134240.GD18785@redhat.com>
References: <20141113.113011.630216167285231824.d.hatayama@jp.fujitsu.com>
 <20141215151120.b44112413e15a8c390d39147@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141215151120.b44112413e15a8c390d39147@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org, ebiederm@xmission.com, anderson@redhat.com

On Mon, Dec 15, 2014 at 03:11:20PM -0800, Andrew Morton wrote:
> 
> (cc trimmed a bit)
> 
> On Thu, 13 Nov 2014 11:30:11 +0900 (JST) HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > Currently, VMCOREINFO note information reports the virtual address of
> > phys_base that is assigned to symbol phys_base. But this doesn't make
> > sense because to refer to phys_base, it's necessary to get the value
> > of phys_base itself we are now about to refer to.
> 
> Folks, could we please get a bit of reviewing, acking or nacking for
> this one?

To me this patch is more like a hack or a quick fix to get dump filtering
working when dump is generated using virsh-dump like tools. I feel there
should be discussion on what's the proper way to do this. I don't have
very specific ideas though at this point of time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
