Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail5.windriver.com ([192.103.53.11] helo=mail5.wrs.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bOESO-0003uV-8B
 for kexec@lists.infradead.org; Sat, 16 Jul 2016 01:31:52 +0000
Message-ID: <57898E6A.5080101@windriver.com>
Date: Sat, 16 Jul 2016 09:31:22 +0800
From: Lans Zhang <jia.zhang@windriver.com>
MIME-Version: 1.0
Subject: Re: [V2][PATCH 1/2] PKCS#7: Fix kernel panic when referring to the
 empty AuthorityKeyIdentifier
References: <1468416937-21237-1-git-send-email-jia.zhang@windriver.com>
 <3760.1468594137@warthog.procyon.org.uk>
In-Reply-To: <3760.1468594137@warthog.procyon.org.uk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, linux-crypto@vger.kernel.org

On 07/15/2016 10:48 PM, David Howells wrote:
> Lans Zhang<jia.zhang@windriver.com>  wrote:
>
>> This fix resolves the following kernel panic if the empty
>> AuthorityKeyIdentifier employed.
>
> It should be noted that this is only an issue if DEBUG is #defined at the top
> of pkcs7_verify.c as the crash happens in a pr_debug() statement.
>

Yep and your previous analysis is correct.

Let me know if I need to add this comment to commit header.

Cheers,
Jia

> David
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
