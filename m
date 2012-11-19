Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TaZul-0006N8-S5
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 22:34:04 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so926978bkc.36
 for <kexec@lists.infradead.org>; Mon, 19 Nov 2012 14:34:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121119210001.GI10035@redhat.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <20121119210001.GI10035@redhat.com>
Date: Mon, 19 Nov 2012 14:34:00 -0800
Message-ID: <CAE9FiQX3cohb5VqTZ4Hb2Hf+nK89s5BfyVyGHnV_78105r9g4w@mail.gmail.com>
Subject: Re: [PATCH 0/8] kexec: put bzImage and ramdisk above 4G for x86 64bit
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Nov 19, 2012 at 1:00 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> here patches are for kexec tools to load bzImage and ramdisk high acccording
>> to new added boot header fields.
>
> So does this allow me to load other segments also above 4G? (purgatory,
> setup/bootparams, command line etc). I remember that purgaotry has
> some 32bit relocations so had to be loaded below 2G.

for 64bit bzImage, yes.

Eric update purgartory code to support that can not be loaded above 4G ...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
