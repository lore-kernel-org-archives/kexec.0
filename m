Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFSbc-0002ue-Iw
 for kexec@lists.infradead.org; Tue, 08 Sep 2020 01:39:33 +0000
From: piliu <piliu@redhat.com>
Subject: makedumpfile: a feature question about filtering
Message-ID: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
Date: Tue, 8 Sep 2020 09:38:07 +0800
MIME-Version: 1.0
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>

Hello,

There is an appeal which only wants to save some user page including env
and args pages, and discards the other user space pages.

To achieve this feature, mm_struct's members "arg_start, arg_end,
env_start, env_end;" should be accessed. So we need to export mm_struct
and init_mm through vmcore.

This somewhat overlaps with the function of crash utility. And I want to
know if this feature is acceptable in upstream.

Any comment and suggestion?

Thanks,
Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
