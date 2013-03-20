Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIM69-0004Bz-5j
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 16:42:46 +0000
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 10:42:40 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4330E1FF004A
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 10:37:34 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2KGgQvs057956
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 10:42:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2KGg0ZW007152
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 10:42:00 -0600
Message-ID: <1363797717.2580.10.camel@falcor1.watson.ibm.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 12:41:57 -0400
In-Reply-To: <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <alpine.LRH.2.02.1303191542200.30973@tundra.namei.org>
Mime-Version: 1.0
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

On Tue, 2013-03-19 at 15:47 +1100, James Morris wrote:
> On Mon, 18 Mar 2013, Matthew Garrett wrote:
> 
> > This patch introduces CAP_COMPROMISE_KERNEL. 
> 
> I'd like to see this named CAP_MODIFY_KERNEL, which is more accurate and 
> less emotive.  Otherwise I think core kernel developers will be scratching 
> their head over where to sprinkle this.
> 
> Apart from that, I like the idea, especially when it's wired up to MAC 
> security.

Matthrew, perhaps you could clarify whether this will be tied to MAC
security.  Based on the kexec thread, I'm under the impression that is
not the intention, or at least not for kexec.  As root isn't trusted,
neither is the boot command line, nor any policy that is loaded by root,
including those for MAC.

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
