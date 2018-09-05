Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxP5b-0004pC-3Q
 for kexec@lists.infradead.org; Wed, 05 Sep 2018 04:06:48 +0000
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
Date: Tue, 4 Sep 2018 21:06:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
Content-Language: en-US
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On 09/04/18 01:42, Kirill A. Shutemov wrote:
> 
> Switching between 4- and 5-level paging modes (in either direction)
> requires paing disabling. It means the code that does the switching has to
> be under 4G otherwise we would lose control.
> 
> We handle the switching correctly in kernel decompression code, but not on
> kexec caller side.
> 
> XLF_5LEVEL indicates that kernel decompression code can deal with
> switching between paging modes and it's safe to jump there in 5-level
> paging mode.
> 
> As an alternative we can change kexec to switch to 4-level paging mode
> before starting the new kernel. Not sure how hard it will be.
> 

Have a flag saying entering in 5-level mode is fine.  However, you really
should support returning to 4-level mode in kexec.  It is *much* easier to do
on the caller side as you have total control of memory allocation there.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
