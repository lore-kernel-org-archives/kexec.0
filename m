Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTx2V-0004Cs-9J
 for kexec@lists.infradead.org; Thu, 11 Feb 2016 19:36:32 +0000
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 01:06:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1BJZsHs9502994
 for <kexec@lists.infradead.org>; Fri, 12 Feb 2016 01:05:54 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1C15bdf032189
 for <kexec@lists.infradead.org>; Fri, 12 Feb 2016 06:35:37 +0530
Message-ID: <1455219355.2826.1.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 14/22] security: define kernel_read_file hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2016 14:35:55 -0500
In-Reply-To: <56BCBCA9.3040102@schaufler-ca.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-15-git-send-email-zohar@linux.vnet.ibm.com>
 <56BCBCA9.3040102@schaufler-ca.com>
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
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-11 at 08:54 -0800, Casey Schaufler wrote:
> On 2/3/2016 11:06 AM, Mimi Zohar wrote:
> > The kernel_read_file security hook is called prior to reading the file
> > into memory.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> Being able to deny the read prior to performing any
> real work makes a lot of sense.

Thanks, Casey!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
