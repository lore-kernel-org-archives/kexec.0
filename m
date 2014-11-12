Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xog9K-00061r-JC
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 22:12:28 +0000
Date: Wed, 12 Nov 2014 17:12:05 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump, x86: report actual value of phys_base in VMCOREINFO
Message-ID: <20141112221205.GB5265@redhat.com>
References: <20141112.154042.59640143160036130.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141112.154042.59640143160036130.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, anderson@redhat.com, kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Wed, Nov 12, 2014 at 03:40:42PM +0900, HATAYAMA Daisuke wrote:
> Currently, VMCOREINFO note information reports the virtual address of
> phys_base that is assigned to symbol phys_base. But this doesn't make
> sense because to refer to value of the phys_base, it's necessary to
> get the value of phys_base itself we are now about to refer to.
> 

Hi Hatayama,

/proc/vmcore ELF headers have virtual address information and using
that you should be able to read actual value of phys_base. gdb deals
with virtual addresses all the time and can read value of any symbol
using those headers.

So I am not sure what's the need for exporting actual value of
phys_base.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
