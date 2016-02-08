Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([125.16.236.9])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aSvKk-0001vj-Sx
 for kexec@lists.infradead.org; Mon, 08 Feb 2016 23:35:07 +0000
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 05:04:41 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u18NYbHt11993582
 for <kexec@lists.infradead.org>; Tue, 9 Feb 2016 05:04:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u18NYZbT002291
 for <kexec@lists.infradead.org>; Tue, 9 Feb 2016 05:04:37 +0530
Message-ID: <1454974470.3037.46.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2016 18:34:30 -0500
In-Reply-To: <20160207201000.GJ17321@localhost>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
 <20160207201000.GJ17321@localhost>
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
To: Petko Manolov <petkan@mip-labs.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Sun, 2016-02-07 at 22:10 +0200, Petko Manolov wrote:
> On 16-02-03 14:06:27, Mimi Zohar wrote:
 
> > Option 3: incorportate the ima_hooks enumeration into kernel_read_file_id,
> > perhaps changing the enumeration name.
> > 
> > For now, duplicate the new READING_KEXEC_IMAGE/INITRAMFS in ima_hooks.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Option 3 seems the right way to go, but for now:

I'm just not sure.  The kernel_read_file_id enumeration is in
<linux/fs.h>.

> Acked-by: Petko Manolov <petkan@mip-labs.com>

Thank you.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
