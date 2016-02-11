Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTqfb-0000Vq-Tq
 for kexec@lists.infradead.org; Thu, 11 Feb 2016 12:48:28 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 22:17:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2556C2BB0055
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 23:17:45 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1BCHb5B29425732
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 23:17:45 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1BCHClv023168
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 23:17:12 +1100
Message-ID: <1455193012.2538.318.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2016 07:16:52 -0500
In-Reply-To: <CACE9dm-VTDNaEJPGamhMY239LQAPCRYp9rvnwbmZijyo7Vh43g@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm9cqE5cu=0+LujHOGP9XyhGNxYfy52Ds6z+pz+fPwF+pw@mail.gmail.com>
 <1455146516.2538.237.camel@linux.vnet.ibm.com>
 <CACE9dm8OJ1cgbKszUG-pCiEMVarUFLLWi_jewVV-JEMGAJsA-g@mail.gmail.com>
 <1455156500.2538.268.camel@linux.vnet.ibm.com>
 <CACE9dm-VTDNaEJPGamhMY239LQAPCRYp9rvnwbmZijyo7Vh43g@mail.gmail.com>
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
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-11 at 10:47 +0200, Dmitry Kasatkin wrote:
> On Thu, Feb 11, 2016 at 4:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:

> static int idmap[] = {
>          [READING_FIRMWARE] = FIRMWARE_CHECK,
>          [READING_MODULE] = MODULE_CHECK,
>          ...
> };

That works nicely, even with non-sequential ordering or missing entries.
The switch case be replaced with a single line:

func = read_idmap[read_id] == 0 ? FILE_CHECK : read_idmap[read_id]; 

Thank you!

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
