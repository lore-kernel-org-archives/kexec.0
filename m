Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ujlyp-0004xj-5r
 for kexec@lists.infradead.org; Tue, 04 Jun 2013 07:48:33 +0000
Date: Tue, 4 Jun 2013 16:36:47 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile security key filtering with EPPIC scripts
Message-Id: <20130604163647.0e1fb538bf7e9bd14a5e83c8@mxc.nes.nec.co.jp>
In-Reply-To: <51A87F6A.6090407@linux.vnet.ibm.com>
References: <51A87F6A.6090407@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: aruna@linux.vnet.ibm.com
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, ananth@in.ibm.com, BUENDGEN@de.ibm.com

Hello Aruna,

On Fri, 31 May 2013 16:16:02 +0530
Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com> wrote:

> Hi Atsushi/Tachibana,
> 
> Now that upstream makedumpfile has eppic support, we are working
> on sample EPPIC scripts that can be used with makedumpfile to scrub
> confidential data from the vmcore. With these sample scripts as a
> reference, customers can come up with their own EPPIC scripts. We are
> looking for the possibility of pushing these sample EPPIC scripts to
> upstream makedumpfile. Please let me know your opinion on this.

Upstream makedumpfile includes makedumpfile.conf as a sample configuration
of the scrubbing feature, so I have no objection to doing the same thing
for EPPIC.

If you make sample EPPIC scripts by reference to makedumpfile.conf,
you can post them to be reviewed.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
