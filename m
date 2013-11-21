Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZic-0004eY-RW
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 19:15:15 +0000
Date: Thu, 21 Nov 2013 14:14:46 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131121191446.GL16208@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <CAMuHMdVoGC3+q2UKvogL=BjkXO3k3Dq9+gGF+7CczG-PJcQPxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdVoGC3+q2UKvogL=BjkXO3k3Dq9+gGF+7CczG-PJcQPxw@mail.gmail.com>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Greg Kroah-Hartman <greg@kroah.com>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Nov 21, 2013 at 08:06:02PM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 20, 2013 at 6:50 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > Now a new system call kexec_file_load() is implemented which takes
> > kernel fd and initrd fd as parameters. Now kernel should be able
> > to verify signature of newly loaded kernel.
> 
> Only kernel fd and initrd fd?
> What about other fds (e.g. device tree, bootinfo)?

Now bootparams and any other stuff is prepared by kernel. So like a
bootloader we just need to know 3 things. Kernel, initrd and command line
and kernel should do the rest.

In future we can define few flags to alter the loading behavior. Like
force 32bit or 16bit entry instead of default 64bit for bzImage.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
