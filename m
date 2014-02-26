Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIgYD-0003bh-TB
 for kexec@lists.infradead.org; Wed, 26 Feb 2014 15:37:39 +0000
Date: Wed, 26 Feb 2014 16:37:09 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 06/11] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140226153709.GE22639@pd.tnic>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-7-git-send-email-vgoyal@redhat.com>
 <20140221145910.GE11531@pd.tnic> <20140224164131.GJ4631@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140224164131.GJ4631@redhat.com>
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
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Mon, Feb 24, 2014 at 11:41:31AM -0500, Vivek Goyal wrote:
> Right now there is only one user. But once other image loader support
> comes along or other arches support file based kexec, they can make
> use of same function.
> 
> This is a pretty important modification as it decides what's the starting
> point of next kernel image. I wanted to make it a function callable by
> users who wanted to modify it instead of of letting them directly 
> modify image->start.

But are you expecting any other way to set image->start by the other
arches/image loaders?

> Could be. I am trying to reuse exisitng code. In current code, user space
> passes a list of segments and then kernel calls this function to make sure
> all the segments passed in make sense.
> 
> Here also arch dependent part of kernel is preparing a list of segments
> wanted and then generic code is reusing the existing function to make
> sure segment list is sane. I like code reuse part of it.

Right, ok, this was just an idea. Maybe not worth it.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
