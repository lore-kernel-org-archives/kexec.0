Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VelzJ-0003dC-A2
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 13:20:37 +0000
Message-ID: <527CE50D.1070705@citrix.com>
Date: Fri, 8 Nov 2013 13:20:13 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527C054D.4090606@citrix.com>
 <20131107214138.GD11159@olila.local.net-space.pl>
In-Reply-To: <20131107214138.GD11159@olila.local.net-space.pl>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On 07/11/13 21:41, Daniel Kiper wrote:
> 
> I am doing tests in QEMU and using QEMU's -gdb option.

Er.  I'm not sure this is a very interesting real world use case.  I
would suggest the failure here is more likely to be bugs in qemu's
emulation.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
