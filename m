Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XGu37-0005DO-RR
 for kexec@lists.infradead.org; Mon, 11 Aug 2014 18:10:26 +0000
Message-ID: <53E906B0.5040105@zytor.com>
Date: Mon, 11 Aug 2014 11:08:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 11/15] purgatory: Core purgatory functionality
References: <1403814824-7587-1-git-send-email-vgoyal@redhat.com>
 <1403814824-7587-12-git-send-email-vgoyal@redhat.com>
 <20140811174017.GD12610@digium.com> <53E9028E.2070709@zytor.com>
 <20140811180213.GC1863@redhat.com>
In-Reply-To: <20140811180213.GC1863@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Shaun Ruffell <sruffell@digium.com>, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On 08/11/2014 11:02 AM, Vivek Goyal wrote:
> 
> Hi hpa,
> 
> I took it because kexec-tools uses it and in one of the committs Eric
> gave following reasoning.
> 
>     On x86_64 use -mcmodel=large so that the code is built without
>     any 32bit assumptions.  -mcmodel=medium and -mcmodel=small
>     result int code that has 32bit relocations against variables
>     that can live anywhere in the address space
> 
> We do want to load purgatory anywhere in the address space. 
> 
> But if there are other ways to achieve the same thing, I will do that
> change.
> 
> So when you say "small PIC", I need to use -mcmodel=small and -fPIC?
> 

Actually -fPIE is probably better than -fPIC.

-mcmodel=large is incompatible with all other code out there, which
means that even though it is supposed to work it will be poorly tested
at best.  So even despite the gcc version issue, using the small PIC
model would be better.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
