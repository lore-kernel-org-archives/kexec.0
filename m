Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rue8L-0002i2-H9
 for kexec@lists.infradead.org; Tue, 07 Feb 2012 06:02:32 +0000
Date: Tue, 7 Feb 2012 14:58:39 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/3][makedumpfile]Add support for  PPC32
Message-Id: <20120207145839.f7e9fcfd.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F2F9843.9000108@in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
 <20120119115852.588bf8bb.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F2F9843.9000108@in.ibm.com>
Mime-Version: 1.0
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
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp

Hi Suzuki,

On Mon, 06 Feb 2012 14:37:15 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> On 01/19/2012 08:28 AM, Atsushi Kumagai wrote:
> 
> >
> > Thank you for your patches.
> > I will review them.
> 
> Did you get a chance to review my patches ?
> 
> Suzuki
 
I'm reviewing your patches now, and I will inform you
of the result in the course of this week.

Additionally, the followings are scheduled for v1.4.3.

 - Add support for PPC32
 - Fix VtoP method for x86 remap allocator
 - Fix segmentation fault for -x/--split options
 - Support newer kernels

v1.4.3 will be released before the end of this month
if all steps go smoothly.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
