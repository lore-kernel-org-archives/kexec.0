Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIMz9-0003hF-GC
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 18:44:08 +0000
Date: Tue, 25 Feb 2014 13:43:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 08/11] kexec-bzImage: Support for loading bzImage using
 64bit entry
Message-ID: <20140225184342.GF2701@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-9-git-send-email-vgoyal@redhat.com>
 <530CE320.6000808@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530CE320.6000808@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, greg@kroah.com

On Tue, Feb 25, 2014 at 10:38:24AM -0800, H. Peter Anvin wrote:
> On 01/27/2014 10:57 AM, Vivek Goyal wrote:
> > This is loader specific code which can load bzImage and set it up for
> > 64bit entry. This does not take care of 32bit entry or real mode entry
> > yet.
> 
> Is there any use in that?  Real mode entry especially is more than a bit
> scary when coming from another kernel already...

I think 64bit entry should be good for x86_64. When we start supporting
this new system call on x86(32bit), then we can implement 32bit entry 
support (which should not be hard).

I have no plans to implement 16bit entry support. I just wanted to mention
explicitly what is currently supported.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
