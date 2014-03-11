Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNMs9-00074r-9T
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 13:37:34 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2BDbBv5027467
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Tue, 11 Mar 2014 09:37:11 -0400
Date: Tue, 11 Mar 2014 09:37:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] vmcore-dmesg stack smashing happend in extreme case
Message-ID: <20140311133710.GA14785@redhat.com>
References: <1394443511-4243-1-git-send-email-zzou@redhat.com>
 <20140310211650.GI4352@redhat.com>
 <1671814704.13309372.1394502138298.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671814704.13309372.1394502138298.JavaMail.zimbra@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhi Zou <zzou@redhat.com>
Cc: kexec@lists.infradead.org

On Mon, Mar 10, 2014 at 09:42:18PM -0400, Zhi Zou wrote:

[..]
> > 
> > And we don't have to do this twice. Just do it once inside innermost
> > for loop.
> 
> At the beginning, I think it is unnecessary to do this twice too. But
> if the text_len ==0  then the for loop won't be executed and check won't
> be executed either. May be this situation never come up, considering it's
> cost, I can accept it because most of time we just do the check instead of
> write. If it is sure that text_len == 0 never come up, then we should remove
> it.

When do we get text_len=0? If text_len=0, then we are just printing time
stamp? Does it really happen?

I think do a quick test and if we are not encountering such cases, don't
worry about it right now. Making logic too complicated does not help.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
