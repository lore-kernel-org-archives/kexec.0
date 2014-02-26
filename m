Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIhVa-0006L2-1f
 for kexec@lists.infradead.org; Wed, 26 Feb 2014 16:38:58 +0000
Date: Wed, 26 Feb 2014 10:46:54 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 06/11] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140226154654.GB23022@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-7-git-send-email-vgoyal@redhat.com>
 <20140221145910.GE11531@pd.tnic> <20140224164131.GJ4631@redhat.com>
 <20140226153709.GE22639@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140226153709.GE22639@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Wed, Feb 26, 2014 at 04:37:09PM +0100, Borislav Petkov wrote:
> On Mon, Feb 24, 2014 at 11:41:31AM -0500, Vivek Goyal wrote:
> > Right now there is only one user. But once other image loader support
> > comes along or other arches support file based kexec, they can make
> > use of same function.
> > 
> > This is a pretty important modification as it decides what's the starting
> > point of next kernel image. I wanted to make it a function callable by
> > users who wanted to modify it instead of of letting them directly 
> > modify image->start.
> 
> But are you expecting any other way to set image->start by the other
> arches/image loaders?

No. I am expecting other loaders to just call this function to set the
start of kernel image.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
