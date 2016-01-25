Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aNbBL-0006sO-N6
 for kexec@lists.infradead.org; Mon, 25 Jan 2016 07:03:24 +0000
Date: Mon, 25 Jan 2016 15:02:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2 06/11] kexec: replace call to copy_file_from_fd()
 with kernel version
Message-ID: <20160125070246.GD5616@dhcp-128-65.nay.redhat.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-7-git-send-email-zohar@linux.vnet.ibm.com>
 <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160125063712.GC5616@dhcp-128-65.nay.redhat.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

> > diff --git a/fs/exec.c b/fs/exec.c
> > index 211b81c..a5ae51e 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -884,6 +884,21 @@ out:
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file);
> >  
> > +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> > +			     int policy_id)
> 
> Though this is only used in kexec now, it looks more a general function, move it
> to general code should be fine along with kernel_read_file 

Oops, seems I misread exec.c as kexec.c

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
