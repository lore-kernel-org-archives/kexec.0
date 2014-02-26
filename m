Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIfrE-0001w0-Cu
 for kexec@lists.infradead.org; Wed, 26 Feb 2014 14:53:12 +0000
Date: Wed, 26 Feb 2014 09:52:46 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 07/11] kexec: Create a relocatable object called purgatory
Message-ID: <20140226145246.GA23022@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
 <530B989B.8010507@zytor.com> <20140225164342.GC2701@redhat.com>
 <530CCB0E.3060009@zytor.com> <20140225182002.GD2701@redhat.com>
 <530D068E.4040700@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530D068E.4040700@zytor.com>
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

On Tue, Feb 25, 2014 at 01:09:34PM -0800, H. Peter Anvin wrote:
> On 02/25/2014 10:20 AM, Vivek Goyal wrote:
> > 
> > Please let me know if you don't like the idea and you still think there
> > should be a shared implementation between arch/x86/boot/ and
> > arch/x86/purgatory/.
> > 
> 
> That is what I would *prefer*.  There are some other string functions in
> arch/x86/boot/string.c which also ought to be sharable (and are in
> places already.)
> 

Ok, I will look into it. Possibly move optimized 32bit and 64bit version of
memcpy in arch/x86/boot/string.c and include it in purgaotry files.

Or we could define new C version of routines in boot/string.c and leave
optimized versions where they are.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
