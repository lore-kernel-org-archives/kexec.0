Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z8lOU-0006LK-2M
 for kexec@lists.infradead.org; Sat, 27 Jun 2015 08:23:22 +0000
Date: Sat, 27 Jun 2015 13:52:56 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] makedumpfile: Support ARM64
Message-ID: <20150627082256.GE21646@localhost.localdomain>
References: <d76572d93d25b0196cb2b32c88fd15dc4eb78682.1431714565.git.panand@redhat.com>
 <CAOZdJXWjZmL_K=FmvBU=U3VSDY9R4AucFU16v8CAgQCEe8HYDg@mail.gmail.com>
 <20150624033241.GA22348@localhost.localdomain>
 <558A25A3.60504@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <558A25A3.60504@codeaurora.org>
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
To: Timur Tabi <timur@codeaurora.org>
Cc: virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com, asamson@codeaurora.org, kexec@lists.infradead.org

Hi Timur,

On 23/06/2015:10:36:03 PM, Timur Tabi wrote:
> Pratyush Anand wrote:
> >I can try to find out some time in weekend to refactor arm64 code
> >and then add 3 level, 4K support. May be I will need a Tested-by.
> 
> We'd be more than happy to test any code from you promptly.  We're eager to
> get this to work.

I have done the changes, hopefully it should work, but have not
tested. Let me know, if it works will send them as formal patches
to upstream.

https://github.com/pratyushanand/makedumpfile.git : arm64_support
(9b95423bcea0)

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
