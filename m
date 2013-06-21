Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Upvwk-00031H-Ck
 for kexec@lists.infradead.org; Fri, 21 Jun 2013 07:39:52 +0000
Date: Fri, 21 Jun 2013 16:31:32 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
Message-Id: <20130621163132.91c4e3ce0a56a21a03cc040b@mxc.nes.nec.co.jp>
In-Reply-To: <51C3F1BF.7000508@redhat.com>
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
 <51C24656.1080509@jp.fujitsu.com> <51C28E41.2080903@redhat.com>
 <20130620154334.33a09ca47ec66a1c834db08e@mxc.nes.nec.co.jp>
 <51C39F2C.6090002@jp.fujitsu.com> <51C3F1BF.7000508@redhat.com>
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
To: bhe@redhat.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Fri, 21 Jun 2013 14:25:03 +0800
Baoquan <bhe@redhat.com> wrote:

> > BTW, we can assign non-printable characters as short options. Normally
> > we don't type non-printable characters on console, so it's for free.
> > 
> 
> Hi,
> I think it's good idea. In kexec, some options use below short option
> with a large value. With these indicative MACRO as short option, it will
> make code more readable.
> 
> Then all old short options can be replaced with them.
> 
> #define OPT_MEM_MIN             256
> #define OPT_MEM_MAX             257
> #define OPT_REUSE_INITRD        258
> #define OPT_LOAD_PRESERVE_CONTEXT 259
> #define OPT_LOAD_JUMP_BACK_HELPER 260
> #define OPT_ENTRY               261
> #define OPT_MAX                 262

OK, let's adopt it.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
