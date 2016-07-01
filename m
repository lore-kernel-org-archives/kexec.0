Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bJ4eM-0001Li-66
 for kexec@lists.infradead.org; Fri, 01 Jul 2016 20:02:54 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61K02di025058
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 16:02:32 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wj3maj2q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 01 Jul 2016 16:02:32 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 17:02:29 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 03F29352005C
 for <kexec@lists.infradead.org>; Fri,  1 Jul 2016 16:02:09 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61K2Qg615204620
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 17:02:26 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61K2PLT026912
 for <kexec@lists.infradead.org>; Fri, 1 Jul 2016 17:02:25 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Fri, 01 Jul 2016 17:02:23 -0300
In-Reply-To: <20160701183602.GA4553@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <3713936.n8FBhAAd79@hactar>
 <20160701183602.GA4553@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <3789971.1TYeJNg8TK@hactar>
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
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Freitag, 01 Juli 2016, 14:36:02 schrieb Dave Young:
> On 07/01/16 at 02:51pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 30 Juni 2016, 17:43:57 schrieb Dave Young:
> > > On 06/30/16 at 01:42pm, Thiago Jung Bauermann wrote:
> > > > Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> > I understand that this is all somewhat subjective, so if you still
> > disagree with my points I can provide a patch set implementing the
> > change above.
> I still feel it should be changed if more callbacks being introduced,
> though you can regard it is internal api, like above comment we do not
> need to assign them seperately, the member values can be assigned
> from the beginning.

Ok, I'll implement the changes and submit a v4. Thanks for your review.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
