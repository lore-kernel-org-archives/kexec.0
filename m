Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYYQY-00BaCm-1R
 for kexec@lists.infradead.org; Mon, 19 Apr 2021 18:15:22 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 ot17-20020a17090b3b51b0290109c9ac3c34so20860509pjb.4
 for <kexec@lists.infradead.org>; Mon, 19 Apr 2021 11:15:16 -0700 (PDT)
Date: Mon, 19 Apr 2021 18:15:14 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 2/2] fs/kernel_read_file: use
 usermodehelper_read_trylock() as a stop gap
Message-ID: <20210419181514.GM4332@42.do-not-panic.com>
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416235850.23690-3-mcgrof@kernel.org>
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
To: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 11:58:50PM +0000, Luis Chamberlain wrote:
> The endless wait for the read which the piece of hardware never got
> stalls resume as sync calls are all asynchronous.

Sorry, this should read:

The endless wait for the read, which the piece of hardware never got,
stalls resume as all pm resume calls are serialized and synchronous.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
