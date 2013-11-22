Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjfyB-0003OG-Tx
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 01:55:45 +0000
Date: Thu, 21 Nov 2013 20:55:18 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/6] kexec: A new system call to allow in kernel loading
Message-ID: <20131122015518.GA31921@redhat.com>
References: <1384969851-7251-1-git-send-email-vgoyal@redhat.com>
 <8761rl73s7.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8761rl73s7.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com, hpa@zytor.com

On Thu, Nov 21, 2013 at 03:07:04PM -0800, Eric W. Biederman wrote:

[..]
> 
> Before you are done we need an ELF loader.  bzImage really is very
> uninteresting.  To the point I am not at all convinced that an in kernel
> loader should support it.

Hi Eric,

Why ELF case is so interesting. I have not use kexec to boot ELF
images in years and have not seen others using it too. In fact bzImage
seems to be the most common kernel image format for x86, most of the distros
ship and use.

So first I did the loader for the common use case. There is no reason 
that one can't write another loader for ELF images. It just bloats
the code. Hence I thought that other image loaders can follow slowly. I am
not sure why do you say that bzImage is uninteresting. 

> 
> There is also a huge missing piece of this in that your purgatory is not
> checking a hash of the loaded image before jumping too it.  Without that
> this is a huge regression at least for the kexec on panic case.  We
> absolutely need to check that the kernel sitting around in memory has
> not been corrupted before we let it run very far.

Agreed. This should not be hard. It is just a matter of calcualting
digest of segments. I will store it in kimge and verify digest again
before passing control to control page. Will fix it in next version.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
