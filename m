Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URda8-0002e6-Sw
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 07:12:06 +0000
Date: Mon, 15 Apr 2013 16:02:38 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 1/2] Move scrubbing process from reader to writer.
Message-Id: <20130415160238.2d54c75f09af9bcc7601d76b@mxc.nes.nec.co.jp>
In-Reply-To: <51680C4D.1090309@linux.vnet.ibm.com>
References: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
 <20130412151756.afe14ce0df4cdd8bf96be9e6@mxc.nes.nec.co.jp>
 <51680C4D.1090309@linux.vnet.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: ptesarik@suse.cz, kexec@lists.infradead.org

Hello Mahesh,

On Fri, 12 Apr 2013 18:59:49 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 04/12/2013 11:47 AM, Atsushi Kumagai wrote:
> > From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> > Date: Thu, 11 Apr 2013 09:36:36 +0900
> > Subject: [PATCH 1/2] Move scrubbing process from reader to writer.
> > 
> > When create a dumpfile in the kdump-compressed format, scrubbing
> > process is done in reading process via read_pfn(). But it would be
> > better to do it just before actually writing the data like the
> > case of ELF.
> > 
> > Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> 
> Hi Atsushi,
> 
> Changes looks good to me.
> 
> Thanks,
> -Mahesh.

I'm glad to hear that from you, thanks!


Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
