Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjZTH-00040p-Vn
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 18:59:24 +0000
Date: Thu, 21 Nov 2013 10:59:00 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/6] kexec: Export vmcoreinfo note size properly
Message-ID: <20131121185900.GB17070@kroah.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <1384969851-7251-2-git-send-email-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384969851-7251-2-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Wed, Nov 20, 2013 at 12:50:46PM -0500, Vivek Goyal wrote:
> Right now we seem to be exporting the max data size contained inside
> vmcoreinfo note. But this does not include the size of meta data around
> vmcore info data. Like name of the note and starting and ending elf_note.
> 
> I think user space expects total size and that size is put in PT_NOTE
> elf header.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/ksysfs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

This should go into 3.13, right?

Nice fix.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
