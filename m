Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI7Re-0004Cf-Bu
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 01:03:58 +0000
Message-ID: <51490AF6.4080707@zytor.com>
Date: Tue, 19 Mar 2013 18:03:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
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
To: James Morris <jmorris@namei.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org

On 03/18/2013 09:47 PM, James Morris wrote:
> On Mon, 18 Mar 2013, Matthew Garrett wrote:
> 
>> This patch introduces CAP_COMPROMISE_KERNEL. 
> 
> I'd like to see this named CAP_MODIFY_KERNEL, which is more accurate and 
> less emotive.  Otherwise I think core kernel developers will be scratching 
> their head over where to sprinkle this.
> 
> Apart from that, I like the idea, especially when it's wired up to MAC 
> security.

The wiring up to MAC security is a nice touch.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
