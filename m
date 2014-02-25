Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WINc3-0004sn-25
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 19:24:20 +0000
Date: Tue, 25 Feb 2014 13:20:02 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 07/11] kexec: Create a relocatable object called purgatory
Message-ID: <20140225182002.GD2701@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
 <530B989B.8010507@zytor.com> <20140225164342.GC2701@redhat.com>
 <530CCB0E.3060009@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530CCB0E.3060009@zytor.com>
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

On Tue, Feb 25, 2014 at 08:55:42AM -0800, H. Peter Anvin wrote:
> On 02/25/2014 08:43 AM, Vivek Goyal wrote:
> > 
> > W.r.t sharing the code with arch/x86/boot/, I am not sure how to do it.
> > 
> 
> Pretty much we have been doing #includes (a bit sad, I know)... there
> are already a lot of them between arch/x86/boot,
> arch/x86/boot/compressed, and arch/x86/realmode.  In that sense
> collecting these "limited environments" together and have these kinds of
> stuff together in one place seems like a good idea.
> 
> Does purgatory move large amounts of data around?  If so, we probably
> *do* want to use rep movsl, but otherwise you're definitely right, using
> C code makes more sense.

No, I don't move lots of data around in purgatory. We just copy backup
region and that's 640KB of data. 

So we don't copy a lot and it is not a performance sensitive path. 

Hence I would like to keep it simple. That is have C version of memcpy()
in purgatory() which works both for 32bit and 64bit and reuse that across
purgatory code.

Please let me know if you don't like the idea and you still think there
should be a shared implementation between arch/x86/boot/ and
arch/x86/purgatory/.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
