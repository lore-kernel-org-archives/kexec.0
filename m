Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw13.technion.ac.il ([132.68.225.13])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKVR1-0008Rf-TR
 for kexec@lists.infradead.org; Wed, 18 Apr 2012 14:00:44 +0000
Date: Wed, 18 Apr 2012 16:47:44 +0300
From: Nadav Har'El <nyh@math.technion.ac.il>
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
Message-ID: <20120418134743.GA25786@fermat.math.technion.ac.il>
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F8D1F46.3090901@redhat.com>
 <4F8D9F20.9050507@codemonkey.ws> <4F8EAFF7.2040505@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F8EAFF7.2040505@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: kexec@lists.infradead.org, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, linux-kernel@vger.kernel.org

On Wed, Apr 18, 2012, Avi Kivity wrote about "Re: [PATCH 0/4] Export offsets of VMCS fields as note information for kdump":
> Right; they're also not required to be in memory at all - the processor
> can cache them, even for VMCSs that are not active at this time. 
> Running VMXOFF at panic time can fix that, but you have to broadcast it
> to all processors, probably using NMI...

I believe that a VMCLEAR ensures that the VMCS is written back to
memory. KVM uses this fact when migrating a VMCS between two separate
physical CPUs - it runs VMCLEAR on the old CPU, to write the VMCS to
memory, and then VMPTRLD on the new CPU.

So you don't need to VMXOFF, but do need to VMCLEAR. But there's still
the complication that you mention - you need to do the VMCLEAR on the right
processor...


-- 
Nadav Har'El                        |                 Wednesday, Apr 18 2012, 
nyh@math.technion.ac.il             |-----------------------------------------
Phone +972-523-790466, ICQ 13349191 |The only "intuitive" interface is the
http://nadav.harel.org.il           |nipple. After that, it's all learned.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
