Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vwp2514.webpack.hosteurope.de ([2a01:488:42:1000:57e6:2a18::])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjWMP-000883-Sq
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 14:35:35 +0000
Message-ID: <1355495728.21801.33.camel@sven>
Subject: Re: Re:
From: Sven Neumann <s.neumann@raumfeld.com>
Date: Fri, 14 Dec 2012 15:35:28 +0100
In-Reply-To: <CAJXQGf+PoAZY+HcEGSCK_9hS7a3SXX76evENmugbd0uUSZ0Bug@mail.gmail.com>
References: <CAJXQGfJRQ9SO5MLpG5RC1DffaRRaWvRzpX1Rq=wEM5V=Pm31EA@mail.gmail.com>
 <50B8C259.9080902@gmail.com>
 <CAJXQGf+PoAZY+HcEGSCK_9hS7a3SXX76evENmugbd0uUSZ0Bug@mail.gmail.com>
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
To: Naresh Bhat <nareshgbhat@gmail.com>
Cc: magnus.damm@gmail.com, kexec@lists.infradead.org, Daniel Mack <zonque@gmail.com>

Hi,

On Fri, 2012-12-14 at 19:39 +0530, Naresh Bhat wrote:

> I can see you have tested a patch from "Daniel Mack"
> http://lists.infradead.org/pipermail/kexec/2012-December/007526.html
> 
> Can you please help me with the following
> 
> 1. On which target it has been tested ?
> 2. Which kernel is used for testing ?
> 3. What are the --command-line arguments you have passed ?

The target is a custom hardware based on an TI AM33xx ARM Cortex A8
processor. The platform is quite similar to a Beaglebone.

We've tested with Linux 3.7-rc8.

We used

 kexec --append="`cat /proc/cmdline` <extra-parameter>" --dtb=<device-tree-blob> --force uImage

where <extra-parameter> is an extra boot parameter that we append to the
currently used cmdline and <device-tree-blob> is the filename of a
device-tree-blob created using dtc.


Regards,
Sven



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
